#/bin/bash

#UPDATE APT SOURCE LIST

cat << EOF | sudo tee sources.list
deb http://deb.debian.org/debian buster main
deb-src http://deb.debian.org/debian buster main

deb http://deb.debian.org/debian-security/ buster/updates main
deb-src http://deb.debian.org/debian-security/ buster/updates main

deb http://deb.debian.org/debian buster-updates main
deb-src http://deb.debian.org/debian buster-updates main
EOF

apt update
apt upgrade

#INSTALL NEEDED PROGRAMMS
apt install git -y
apt install sudo -y
