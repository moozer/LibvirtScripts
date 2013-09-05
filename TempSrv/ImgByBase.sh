#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ]; then
	echo usage $0 baseimg newimg
	exit 1
fi

echo Using base image $1 and new image is $2
sudo qemu-img  create -f qcow2 -b $1 $2
