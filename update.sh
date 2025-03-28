#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes


# config:
SIGNINGKEYID="E1F8330A475CD21A"



# gpg --armor --export $SIGNINGKEYID > KEY.gpg

#echo "Looking for new deb packages ..."
#NEWDEB=`git status | grep .deb || true`

#if [[ -z "${NEWDEB// }" ]]; then
#    echo "No new deb packages. Done!"
#    exit 0
#fi
#NEWDEB=`echo $NEWDEB | xargs`

echo "Update Package index ..."
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

echo "Create Release file ..."
apt-ftparchive release . > Release

echo "Sign Release file ..."
gpg --default-key $SIGNINGKEYID -abs -o - Release > Release.gpg
echo "Sign Release file with inline signature ..."
gpg --default-key $SIGNINGKEYID --clearsign -o - Release > InRelease

echo "Update PPA .list file ..."
echo "deb [signed-by=/usr/share/keyrings/a-sit-nighty-ppa-keyring.gpg] https://a-sit.github.io/ppa-nightly ./" > file.list


echo "Commit changes back to PPA repo ..."
git add Packages Packages.gz Release Release.gpg InRelease file.list
#git add $NEWDEB
git commit -m "Update PPA" #-m "add $NEWDEB"

echo "update.sh done!"
