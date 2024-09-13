# A-SIT Nightly PPA

A-SIT Nightly PPA (Personal Package Archive) for Ubuntu/Debian Packages. 
Packages in this PPA are directly pushed from the nightly continuous integration pipeline and *not* tested!

**Use at your own risk (or don't use)**!

---


## PPA Usage

First, add the public key of the PPA and the PPA URL to the package manager, and update the package manager

    curl -fsSL https://a-sit.github.io/ppa-nightly/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/a-sit-nighty-ppa-keyring.gpg
    sudo curl -s -o /etc/apt/sources.list.d/asit-nightly.list "https://a-sit.github.io/ppa-nightly/file.list"
    sudo apt update 

Then, you can install the packages found in this repository by simply running

    sudo apt install <package name>
    


## Contents

The repository contains the following software

* [PDF-Over](https://github.com/a-sit/PDF-Over) Nightly: `pdf-over-nightly`



---

Inquiries and bug reports are accepted via the respective issue trackers, or directed to software@egiz.gv.at.

PPA repository adopted from [Michael Schwarz' PPA](https://github.com/misc0110/ppa)
