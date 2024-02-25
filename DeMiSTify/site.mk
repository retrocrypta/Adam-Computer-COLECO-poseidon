# Copy this file to site.mk and edit the paths accordingly.

# Build cores for the following boards.
# If you just want to build for a single board then supply BOARD=boardname
# as part of the make command.

BOARDS=chameleon64 chameleon64v2 de10lite deca neptuno sidi uareloaded atlas_cyc poseidon-ep4cgx150

# If you're building for multiple boards you might need to have multiple versions
# of Quartus installed.  Since you can't have more than one version in your
# search path, we have to locate them using absolute paths.

# Q13 for older devices.  13.0sp1 supports Cyclone II
# while 13.1 is the last version to support Cyclone III

Q13 = /mnt/Teradisk/Quartus13/quartus/bin/


# Q18 for newer devices - I believe anything from version 15 upwards
# will support the boards of interest.

Q17 = /mnt/Teradisk/Quartus/quartus/bin/

# Q17 specifically for MiSTer - not used by DeMiSTify (yet), but
# useful to have it defined for multi-board projects.

Q17 = /mnt/Teradisk/Quartus/quartus/bin/


# ISE for older Xilinx devices

ISE14 = /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/


# Paths for a version of Quartus supporting each class of device

QUARTUS_CYCLONEII = $(Q13)
QUARTUS_CYCLONEIII = $(Q13)
QUARTUS_CYCLONEIV = $(Q17)
QUARTUS_CYCLONEV = $(Q17)
QUARTUS_CYCLONE10LP = $(Q17)
QUARTUS_MAX10 = $(Q17)

ISE_SPARTAN6 = $(ISE14)
ISE_SPARTAN3 = $(ISE14)


# For multi-board projects, the version of Quartus to use when
# compiling for MiST and MiSTer.

QUARTUS_MIST = $(Q13)
QUARTUS_MISTER = $(Q17)

# A command to be executed when a board has finished compiling.
NOTIFY_BOARDCOMPLETE = notify-send -a DeMiSTify
#NOTIFY_BOARDCOMPLETE = echo -ne '\007'

# A command to be executed when all boards have finished compiling.
NOTIFY_COMPLETE = notify-send -a DeMiSTify
#NOTIFY_COMPLETE = echo -ne '\007'

