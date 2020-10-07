SHELL := /bin/bash

.PHONY: release

# Hack to take arguments from command line
# Usage: `make release 5.5.5`
# https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
release:
	@ grep --silent $(filter-out $@,$(MAKECMDGOALS)) terraform/variables.tf || \
		( echo "ERROR: update the version in terraform/variables.tf before creating the release" && exit 1 )
	@ env GOOS=linux GOARCH=amd64 go build -o build/ssh-key-agent_$(filter-out $@,$(MAKECMDGOALS))_linux_amd64 .
	@ gh release create $(filter-out $@,$(MAKECMDGOALS)) -t $(filter-out $@,$(MAKECMDGOALS))
	@ gh release upload $(filter-out $@,$(MAKECMDGOALS)) build/ssh-key-agent_$(filter-out $@,$(MAKECMDGOALS))_linux_amd64
	@ rm -rf build
	@ echo "SUCCESS!"

%:		# matches any task name
	@:	# empty recipe = do nothing
