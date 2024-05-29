#!/bin/bash

set -euo pipefail

if test -n "$(git status --porcelain)"; then
    echo "ERROR: Repository dirty, please commit the changes and try again."
    exit 1
fi

podman run --privileged --rm -it -v $PWD:/catalog ixsystems/catalog_validation /usr/local/bin/catalog_update publish --path /catalog
podman run --privileged --rm -it -v $PWD:/catalog ixsystems/catalog_validation /usr/local/bin/catalog_update update --path /catalog

git add catalog.json
find -name app_versions.json -exec git add {} +

git commit --amend
