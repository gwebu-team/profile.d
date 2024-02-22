SHELL:=/bin/bash # Use bash syntax, mitigates dash's printf on Debian
ver:=$(shell git describe --tags --always --match='v[0-9]*.[0-9]*' | cut -c 2- | cut -d - -f 1)


help:
	@echo
	@echo "▍Help"
	@echo "▀▀▀▀▀▀"
	@echo
	@echo "Available targets:"
	@echo "    dist:               create source distribution package in dist/"
	@echo "    rpm:                create an RPM package"
	@echo
	@echo "    clean:              clean all generated files"
	@echo
	@echo "Version $(ver)."
.PHONY: help


.PHONY: dist
dist:
	test -d dist || mkdir dist
	git archive --prefix="profile.d-$(ver)/" HEAD | xz -9v > "dist/profile.d-$(ver).tar.xz"


.PHONY: rpm
rpm: dist
	rpmbuild -ta "dist/profile.d-$(ver).tar.xz"


.PHONY: clean
clean:
	rm -rf dist
