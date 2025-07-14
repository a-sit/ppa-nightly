#!/bin/bash
set -o nounset   # abort on unbound variable
#set -o errexit   # abort on nonzero exitstatus
#set -o pipefail  # don't hide errors within pipes

# Script to be run inside the container.

echo "##########################################################"
echo "#################### A-SIT PPA Tester ####################"
echo "##########################################################"
echo ""

pwd

echo ""
echo "#################### Setup PPA ####################"
echo ""

curl -fsSL https://a-sit.github.io/ppa-nightly/KEY.gpg | gpg --dearmor -o /usr/share/keyrings/a-sit-nighty-ppa-keyring.gpg
curl -s -o /etc/apt/sources.list.d/asit-nightly.list "https://a-sit.github.io/ppa-nightly/file.list"
apt update 


echo ""
echo "#################### Explore package ####################"
echo ""

apt-cache policy pdf-over-nightly

apt show pdf-over-nightly

apt-cache depends pdf-over-nightly

echo ""
echo "#################### Install package ####################"
echo ""

apt-get -y install pdf-over-nightly

echo ""
echo "#################### Start package ####################"
echo ""

apt-cache depends pdf-over-nightly

pdf-over-nightly --help
