#!/bin/sh

# Package Name
package="qs.raspi"
version="1.0"
revision="2"
packageName=${package}_${version}-${revision}

echo $packageName

installPath="/usr/share/opencpi"
binPath="/usr/bin"

curDir=`pwd`

# Folder for doing working in
echo "Creating temporary directory"
tmp=$(mktemp -d -t qs.raspi-XXXXXXXX)
echo " > $tmp"

# Create folder structure
mkdir -p $tmp/$packageName/$installPath/applications
mkdir -p $tmp/$packageName/$installPath/artifacts
mkdir -p $tmp/$packageName/$installPath/scripts
mkdir -p $tmp/$packageName/$installPath/pi3/bin
mkdir -p $tmp/$packageName/$installPath/pi3/lib
mkdir -p $tmp/$packageName/$binPath
mkdir -p $tmp/$packageName/DEBIAN

# Copy over OpenCPI runtimes
cp -Lr $OCPI_CDK_DIR/pi3/bin/* $tmp/$packageName/$installPath/pi3/bin/
cp -Lr $OCPI_CDK_DIR/pi3/lib/* $tmp/$packageName/$installPath/pi3/lib/
cp -Lr $OCPI_CDK_DIR/applications/* $tmp/$packageName/$installPath/applications/

# Make relative links
cd $tmp/$packageName/$installPath/pi3/bin/
ln -sr ./ocpirun $tmp/$packageName/$binPath/
ln -sr ./ocpiremote $tmp/$packageName/$binPath/
ln -sr ./ocpiserve $tmp/$packageName/$binPath/

# Find all of the artifacts we want
inc=0
for dir in $OCPI_CDK_DIR/../project-registry/*; do
    echo "$dir"
  if [ -d $dir/artifacts ]; then
    for artifact in $dir/artifacts/*.pi3.*; do
      filename=$(basename $artifact)
      cp -L $artifact $tmp/$packageName/$installPath/artifacts/$inc-$filename
      ((inc++))
    done
  fi 
done

cat >$tmp/$packageName/$installPath/default-system.xml << EOM
<opencpi>
  <container>
    <rcc load='1' />
    <remote load='1' />
  </container>
  <transfer smbsize='100M'>
    <pio load='1' />
    <dma load='1' />
    <socket load='1' />
  </transfer>
</opencpi>
EOM

cat >$tmp/$packageName/DEBIAN/control <<EOM
Package: ${package}
Version: ${version}-${revision}
Section: base
Priority: optional
Architecture: armhf
Maintainer: Martyn <sdrhertz@users.noreply.github.com>
Description: OpenCPI runtime and components for Raspberry Pi 3
EOM

cd ${tmp} && dpkg-deb --build ${package}_${version}-${revision}
cd $curDir
mv $tmp/*.deb ./

# Clean up
echo "Removing temporary directory"
rm -rf $tmp
