SHELL:=/bin/bash # Use bash syntax, mitigates dash's printf on Debian
ver:=$(shell git describe --dirty --long --match='v[0-9]*.[0-9]*' | cut -c 2- | cut -d - -f 1,2,4)
rpm_ver=$(firstword $(subst -, ,$(ver)))
rpm_rev=$(subst $(rpm_ver)-,,$(ver))


help:
	@echo
	@echo "▍Help"
	@echo "▀▀▀▀▀▀"
	@echo
	@echo "Available targets:"
	@echo "    dist:               create source distribution package in dist/"
	@echo "    rpm:                create an RPM package"
	@echo "    changelog:          Add a changelog entry to gwebu-profile.spec.in"
	@echo
	@echo "    clean:              clean all generated files"
	@echo
	@echo "Version $(ver), rpm_ver=$(rpm_ver), rpm_rev=$(rpm_rev)."
.PHONY: help


.PHONY: dist
dist: dist/profile.d-$(ver).tar.xz


dist/profile.d-$(ver).tar.xz:
	test -d dist || mkdir dist
	sed 's/^Version: .*/Version: $(rpm_ver)/' < gwebu-profile.spec.in \
		| sed 's/^Release: .*/Release: $(rpm_rev)/' \
		> gwebu-profile.spec
	git archive --prefix="profile.d-$(ver)/" --add-file=gwebu-profile.spec HEAD | xz -9 > "$@"
	rm gwebu-profile.spec


.PHONY: rpm
rpm: dist
	rpmbuild -ta "dist/profile.d-$(ver).tar.xz"


.PHONY: changelog
changelog:
	./changelog.sh


.PHONY: clean
clean:
	rm -rf dist VERSION
