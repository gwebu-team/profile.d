Summary: Install z-ps-twtty-7.sh and z-time_style.sh
Name: gwebu-profile
Version: 1.0
Release: 2
License: GPLv2
Source0: %{name}-%{version}.tar.gz
BuildArch: noarch
Requires: bash >= 4

%description
Bash prompt look nicer, history ordered by date with exit codes, commands starting with space are not saved

%prep
%setup -q

%build
# No build actions needed for Bash scripts

%install
mkdir -p %{buildroot}%{_sysconfdir}/profile.d
#install -m 755 *.sh %{buildroot}%{_sysconfdir}/profile.d/
install -m 644 *.sh %{buildroot}%{_sysconfdir}/profile.d/
chmod 644 %{buildroot}%{_sysconfdir}/profile.d/*.sh

%files
%defattr(-,root,root,-)
%{_sysconfdir}/profile.d/*.sh

%changelog
* Wed Feb 14 2024 Valentin Todorov <vtodorov@ctw.travel> - 1.0-1
- Initial package.
