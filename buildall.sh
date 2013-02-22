#! /bin/sh

# remove all old packages
rm *.deb

# build the packages
./buildpackage.sh 3.2.27+
./buildpackage.sh 3.6.11+

# build the override file for dpkg-scanpackges
ls -l *.deb > override

# create the package file
dpkg-scanpackages ./ override | gzip > Packages.gz