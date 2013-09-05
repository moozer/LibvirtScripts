LibvirtScripts
==============

A collection of virtual machine scripts that I find useful

Scripts so far
--------------

Usage: CloneToTemp.sh \<domain\>

Running this script clones an existing virtual machine (aka. *domain*) 
and creates an overlay to the existing disc. These are combined and a
new machine is created with the name \<domain\>_$Data_$Time.
