Summary: Gwebu profile.d - cool date, prompt with history, aliases
Name: gwebu-profile
Version: 1.0.0
Release: 3
License: GPLv2
Source0: profile.d-%{version}.tar.xz
BuildArch: noarch
Requires: bash >= 4

%description
This package contains:
  - z-aliases.sh:
    a few useful aliases (l., lll) and colors for ip and less.
  - z-env.sh:
    default editor, history size and fzf integration.
  - z-ps-twtty-7.sh:
    Cool prompt with history organized year-month directories and day by day files.
  - z-time_style.sh:
    sets TIME_STYLE=long-iso

All these reside in /etc/profile.d/.

%prep
%setup -q # -n profile.d-%{version}

%build
# No build actions needed for Bash scripts

%install
mkdir -p %{buildroot}%{_sysconfdir}/profile.d
install -m 0644 etc/profile.d/*.sh %{buildroot}%{_sysconfdir}/profile.d/

%files
%defattr(-,root,root,-)
%{_sysconfdir}/profile.d/*.sh

%changelog
* Wed Feb 21 2024 Doncho N. Gunchev <dgunchev@gmail.com> - 1.0.0-3
- Minor updates.

* Wed Feb 14 2024 Valentin Todorov <vtodorov@ctw.travel> - 1.0-1
- Initial package.
