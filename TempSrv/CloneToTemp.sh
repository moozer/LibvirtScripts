#!/bin/sh

# only one parameter
if [ "$1" = "" ]; then
	echo "usage: $0 <vm-to-clone>"
	exit 1
fi

VMTOCOPY=$1

CURDATE=$(date +"%y%m%d_%H%M")
OLDXMLFILE="tmp_$CURDATE.xml"
sudo virsh dumpxml $VMTOCOPY

# vars
NEWDOMAIN="$1_$CURDATE"
OLDIMG=$(cat $OLDXMLFILE | sed "s#<source file='\(.*\)'/>#\1#" | sed -e 's/^[ \t]*//') # find data, then trim spaces.
NEWIMG="$OLDIMG_$CURDATE.qcow2.img"


echo Cloning virtual machine $VMTOCOPY
echo - will create overlayed image $NEWIMG
echo - base image i $OLDIMG
echo - new domain is $NEWDOMAIN


echo will run
echo ./CloneVm.sh $VMTOCOPY $NEWDOMAIN $NEWIMG

rm $OLDXMLFILE

# yeah! success
exit 0
