#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob dotglob

ver=$(git describe --dirty --long --match='v[0-9]*.[0-9]*' | cut -c 2- | cut -d - -f 1,2,4)
rpm_ver="${ver%%-*}"
rpm_rev="${ver#*-}"
rpm_numeric_rev="${rpm_rev%%-*}"

change1="* $(date +'%a %b %d %Y') $(git log -1 --format='%aN <%aE>') - ${rpm_ver}-${rpm_numeric_rev}"
change2="- $(git log -1 --format=%s)"

awk -v change1="${change1}" -v change2="${change2}" '/^%changelog/ {print; print change1; print change2; print ""; next} 1' gwebu-profile.spec.in \
    > gwebu-profile.spec.tmp && mv gwebu-profile.spec.tmp gwebu-profile.spec.in

sed -i.bak "s/Version: .*/Version: ${rpm_ver}/" gwebu-profile.spec.in
sed -i.bak "s/Release: .*/Release: ${rpm_numeric_rev}/" gwebu-profile.spec.in
rm -f gwebu-profile.spec.in.bak

# git add gwebu-profile.spec.in

echo "gwebu-profile.spec.in changelog updated"
