#! /bin/sh

# remove all old packages
rm *.deb

# build the packages
./buildpackage.sh 3.2.27+
./buildpackage.sh 3.6.11+
./buildpackage.sh 3.6.11+ 538
./buildpackage.sh 3.10.19+ 600
./buildpackage.sh 3.10.24+ 614
./buildpackage.sh 3.10.25+ 622

# copy the packages to the global package folder
cp *.deb ../Documents/packages