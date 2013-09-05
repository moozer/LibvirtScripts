#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ]; then
	echo usage $0 NonflatImage OutputImage
	exit 1
fi

echo Using image $1 and flatten to new image $2
sudo qemu-img convert -O qcow2 $1 $2

