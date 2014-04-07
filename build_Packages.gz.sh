#! /bin/bash

# build the override file for dpkg-scanpackges
ls -l *.deb > override

# create the package file
dpkg-scanpackages ./ override | gzip > Packages.gz
