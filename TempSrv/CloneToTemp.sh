#!/bin/sh

# only one parameter
if [ "$1" = "" ]; then
	echo "usage: $0 <vm-to-clone> [tag]"
	exit 1
fi

if ! which realpath > /dev/null; 
then 
	echo "realpath program not found in PATH"
	echo "user 'apt-get install realpath' or similar"
	exit
fi


PROGDIR=$(dirname $(realpath $0))

VMTOCOPY=$1
CURDATE=$(date +"%y%m%d_%H%M")
OLDXMLFILE="/tmp/tmp_$CURDATE.xml"

if [ ! "$2" = "" ]; then
	TAG="_$2"
else
	TAG=""
fi

# get the xml
sudo virsh dumpxml $VMTOCOPY > $OLDXMLFILE
if [ $? -ne 0 ]; then
	echo something went wrong getting the xml
	exit 2
fi

# vars
NEWDOMAIN="${VMTOCOPY}_$CURDATE$TAG"
OLDIMG=$(cat $OLDXMLFILE | sed -ne "s#<source file='\(.*\)'/>#\1#p" | head -n 1 | sed 's/^ *//g') # find data, then skip all iso, then trim.
NEWIMG="$(dirname $OLDIMG)/$(basename $OLDIMG '.img')_$CURDATE$TAG.img"

echo "Cloning virtual machine $VMTOCOPY"
echo "- base image is $OLDIMG"
echo "- will create overlayed image $NEWIMG"
echo "- new domain is $NEWDOMAIN"

echo Creating new baseimage
$PROGDIR/ImgByBase.sh $OLDIMG $NEWIMG

echo Cloning the domain with new image
$PROGDIR/CloneVm.sh $VMTOCOPY $NEWDOMAIN $NEWIMG

echo Cleaning up
rm $OLDXMLFILE

# yeah! success
exit 0
