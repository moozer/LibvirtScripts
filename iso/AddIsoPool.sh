#!/bin/sh

ISOPATH="/mnt/storage/iso"
ISONAME="iso_images"
TEMPFILE="temp.xml"

echo "adding $ISOPATH as libvirt storage pool"

cat > $TEMPFILE << EOF
<pool type='dir'>
  <name>$ISONAME</name>
  <source>
  </source>
  <target>
    <path>$ISOPATH</path>
    <permissions>
      <mode>0700</mode>
      <owner>4294967295</owner>
      <group>4294967295</group>
    </permissions>
  </target>
</pool>
EOF

# create dir with appropriate permissions
sudo mkdir -p $ISOPATH
sudo chown root:adm $ISOPATH
sudo chmod 745 $ISOPATH

sudo virsh pool-create temp.xml
sudo virsh pool-refresh $ISONAME
rm $TEMPFILE

