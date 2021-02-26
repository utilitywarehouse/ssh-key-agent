package main

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"

	"golang.org/x/crypto/ssh"
)

var (
	uri    = os.Getenv("SKA_KEY_URI")
	groups = os.Getenv("SKA_GROUPS")

	// interval in seconds
	interval = os.Getenv("SKA_INTERVAL")

	// authorized_keys file location
	akfLoc = os.Getenv("SKA_AKF_LOC")
)

type keyMap struct {
	LastUpdated string  `json:"last_updated"`
	Groups      []group `json:"groups"`
}

type group struct {
	Name string   `json:"name"`
	Keys []string `json:"keys"`
}

func validate() {
	if uri == "" {
		log.Fatal("Need to set value for SKA_KEY_URI")
	}
	if groups == "" {
		log.Fatal("Need to set value for SKA_GROUPS")
	}
	if interval == "" {
		log.Fatal("Need to set value for SKA_INTERVAL")
	} else {
		_, err := strconv.Atoi(interval)
		if err != nil {
			log.Fatal("SKA_INTERVAL must be an int")
		}
	}
	if akfLoc == "" {
		log.Fatal("Need to set value for SKA_AKF_LOC")
	}
}

func keysFromMap(keyMap *keyMap) (keys []string) {
	var rawKeys []string
	groupNames := strings.Split(groups, ",")
	for _, gn := range groupNames {
		for _, g := range keyMap.Groups {
			if gn == g.Name {
				for _, k := range g.Keys {
					key, comment, _, _, err := ssh.ParseAuthorizedKey([]byte(k))
					if err != nil {
						log.Printf("%v", err)
						continue
					}
					// sanitize
					fmtKey := strings.TrimSuffix(string(ssh.MarshalAuthorizedKey(key)), "\n") + " " + comment + "\n"
					rawKeys = append(rawKeys, fmtKey)
				}
			}
		}
	}

	// dedup keys
	dk := make(map[string]bool)
	for _, v := range rawKeys {
		if !dk[v] {
			keys = append(keys, v)
			dk[v] = true
		}
	}
	return
}

func writeKeys(keys []string) {
	if len(keys) == 0 {
		log.Printf("Found 0 keys, need at least 1 to write")
		return
	}
	var out []byte
	for _, k := range keys {
		out = append(out, k...)
	}
	err := os.WriteFile(akfLoc, out, 0644)
	if err != nil {
		log.Printf("%v", err)
	}
}

func updateKeys() {
	var keyMap keyMap
	resp, err := http.Get(uri)
	defer func() {
		io.Copy(io.Discard, resp.Body)
		resp.Body.Close()
	}()
	if err != nil {
		log.Printf("%v", err)
		return
	}
	dec := json.NewDecoder(resp.Body)
	err = dec.Decode(&keyMap)
	if err != nil {
		log.Printf("%v", err)
		return
	}
	keys := keysFromMap(&keyMap)
	writeKeys(keys)
}

func sync() {
	intrv, _ := strconv.Atoi(interval)
	for t := time.Tick(time.Second * time.Duration(intrv)); ; <-t {
		updateKeys()
	}
}

func main() {
	validate()
	log.Printf("Running...")
	sync()
}
