# /etc/profile.d files collection

This is a collection of /etc/profile.d files used by the gwebu team.
Unless explicitly stated in the file itself, the license is [The Unlicense](https://choosealicense.com/licenses/unlicense/).

## Hooks

Create the following hook in your local repository to update the RPM changelog for you:


```bash
echo '#!/usr/bin/env bash

set -eu

./changelog.sh' > .git/hooks/post-commit
chmod a+x .git/hooks/post-commit
```
