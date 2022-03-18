#!/bin/bash
source Colors.sh

if [ "$(whoami)" == "root" ]; then
    printlnBlue "Reset fstab configuration.."
    cat "$backupDir/fstab.old" > "/etc/fstab"
    printlnGreen "Uninstall zram success!"
else
    printlnRed "Uninstall failed!"
fi