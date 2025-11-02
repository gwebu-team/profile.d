# /etc/profile.d files collection

This is a collection of /etc/profile.d files used by the gwebu team.
Unless explicitly stated in the file itself, the license is [The Unlicense](https://choosealicense.com/licenses/unlicense/).

## Automation

To update the RPM changelog run ./changelog.sh

Type `make` to see the available targets (dist, rpm, podman_rpm, changelog, clean).

## Releases

To create a new release first tag it:

```shell
git tag -a v1.0.0 -m "Release 1.0.0"
```

then run `./release.sh`. At this point

```shell
git commit -a --ammend
git tag -a v1.0.0 -m "Release 1.0.0" --force
```

This is a chicken and egg problem I have not decided how to solve yet.

Build the RPMs at this point with `make rpm` or `make podman_rpm`.
Once everything is OK push code and the tag.

```shell
git push
git push --tags
```

And draft a new release on GitHub.
