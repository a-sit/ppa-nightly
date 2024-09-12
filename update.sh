#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# config:
SIGNINGKEYID="E1F8330A475CD21A"



# gpg --armor --export $SIGNINGKEYID > KEY.gpg

echo "Looking for new deb packages ..."
NEWDEB=`git status | grep .deb || true`

if [[ -z "${NEWDEB// }" ]]; then
    echo "No new deb packages. Done!"
    exit 0
fi
NEWDEB=`echo $NEWDEB | xargs`


dpkg-scanpackages --multiversion . > Packages

gzip -k -f Packages
apt-ftparchive release . > Release

gpg --default-key $SIGNINGKEYID -abs -o - Release > Release.gpg
gpg --default-key $SIGNINGKEYID --clearsign -o - Release > InRelease

echo "deb https://a-sit/.github.io/ppa-nightly ./" > file.list


git add Packages Packages.gz Release Release.gpg InRelease file.list
git add $NEWDEB
git commit -m "Update PPA content" -m "add $NEWDEB"
