#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ]; then
	echo "usage: $0 <vm-to-promote> <new-name>"
	exit 1
fi
VMTOPROM=$1
NEWNAME=$2

OLDIMG=$(sudo virsh dumpxml $VMTOPROM | sed -ne "s#<source file='\(.*\)'/>#\1#p1" | head -n 1 | sed 's/^ *//g') # find data, then pick first line, then trim.
NEWIMG="$(dirname $OLDIMG)/$2.img"

echo Promoting VM $VMTOPROM
echo - Will flatten image $OLDIMG
echo - New image name $NEWIMG
echo - will rename $VMTOPROM to $NEWNAME
echo
echo Note: Not deleting old VM.

echo
echo Flattening
./ImgFlatten.sh $OLDIMG $NEWIMG

echo
echo Creating new machine
./CloneVm.sh $VMTOPROM $NEWNAME $NEWIMG



