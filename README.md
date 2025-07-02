# pickle-linux

The Pickle Linux repositories.

## `main`

This is the repository holding all the essential packages needed for the distribution to function correctly.
There isn't any dependency specified in those packages as they're all installed together with the base image.

## `user`

This is the repository for all optional packages that can be installed on top of the base image.
Each package installed from this repository will be included in a local image generated on the fly.
