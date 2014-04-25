#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
	echo usage $0 OldDomain NewDomain ImageToUse
	echo Use full path for image
	exit 1
fi

if ! [ -e $3 ]; then
	echo File not found $3
	exit 1
fi

TMPFILENAME="/tmp/tmpxml.xml"
OLDDOMAIN=$1
NEWDOMAIN=$2
NEWDISKIMG=$3

echo copying configuration from $1 and putting it in a new vm $2

# only replace first occurences
echo Dumping olf config
echo - kill line with uuid
echo - Setting VM name to $NEWDOMAIN
echo - Setting first hdd to $NEWDISKIMG
sudo virsh dumpxml $OLDDOMAIN | \
grep -v uuid | \
grep -v "mac address" | \
sed "s#\(<name>\).*\(</name>\)#\1$NEWDOMAIN\2#" | \
sed "s#\(<source file='\).*\('/>\)#\1$NEWDISKIMG\2#"  > $TMPFILENAME

echo creating vm
sudo virsh define $TMPFILENAME

echo it should be in the list
sudo virsh list --all

