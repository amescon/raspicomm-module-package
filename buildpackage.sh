# use the first parameter as the version of the package
if [ -z $1 ] ; then
  echo No Version specified as an argument, using version 3.6.11+  
  VERSION="3.6.11+"
else
  VERSION=$1
fi

# execute make for the module
make -C ../raspicomm-module ${VERSION}

MODULESDIR="./debian/lib/modules"
KODIR="${MODULESDIR}/${VERSION}"

# remove old debian/lib/modules folders
rm -rf ${MODULESDIR}

# create the folder for the specified version if it does not exist
if [ ! -d $KODIR ] ; then
  mkdir -p $KODIR
fi

# copy the kernel module binary to the destination folder
cp ../raspicomm-module/raspicommrs485.ko ${KODIR}/raspicommrs485.ko

# create the package name
PACKAGENAME="raspicommrs485-${VERSION}"

# create the package configuration file based upon the template debian/DEBIAN/control
sed "s/\[PACKAGENAME\]/${PACKAGENAME}/" control.template > debian/DEBIAN/control

# create the package
dpkg -b debian ${PACKAGENAME}.deb