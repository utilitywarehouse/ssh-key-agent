.PHONY: release
release:
	@sd '(^\s*default\s*=\s*")([\d.v]+)("$$)' '$${1}$(VERSION)$${3}' terraform/variables.tf
	@git add -- terraform/variables.tf
	@git commit -m "Release $(VERSION)"
