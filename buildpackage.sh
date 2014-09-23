# use the first parameter as the version of the package
if [[ -z $1 ]]; then
  echo "No Version specified as an argument, using version 3.6.11+"
  VERSION="3.6.11+"
else
  VERSION=$1
fi

# use the 2nd parameter as subversion
if [[ -z $2 ]]; then
  echo "No Subversion specified as an argument, using version as name"
  NAME="$VERSION"
else
	NAME=$1$2
fi

# if arguments 3 & 4 are specified, use them as the binary
if [[ ! -z $3 && ! -z $4 ]]; then
  echo "use ${3} ${4} as the binary base"
  MAKEDIR=${3}${4}
else
  MAKEDIR=${NAME}
fi

# execute make for the module
make -C ../raspicomm-module ${MAKEDIR}

MODULESDIR="./debian/lib/modules"

# kernel module directory
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
PACKAGENAME="raspicommrs485-${NAME}"

# create the package configuration file based upon the template debian/DEBIAN/control
sed "s/\[PACKAGENAME\]/${PACKAGENAME}/" control.template > debian/DEBIAN/control

# create the package
dpkg -b debian ${PACKAGENAME}.deb
