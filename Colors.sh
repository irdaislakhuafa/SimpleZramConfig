#!/bin/bash

# colors
fgRed="[31m"
fgWhite="[37m"
fgGreen="[32m"
fgBlue="[34m"
fgYellow="[33m"

# Red
printlnRed(){
    echo $fgRed"$@"$fgWhite
}
printRed(){
    echo -n $fgRed"$@"$fgWhite
}

# Green
printlnGreen(){
    echo $fgGreen"$@"$fgWhite
}
printGreen(){
    echo -n $fgGreen"$@"$fgWhite
}

# Blue
printlnBlue(){
    echo $fgBlue"$@"$fgWhite
}
printBlue(){
    echo -n $fgBlue"$@"$fgWhite
}

# Yellow
printlnYellow(){
    echo $fgYellow"$@"$fgWhite
}
printYellow(){
    echo -n $fgYellow"$@"$fgWhite
}

backupDir="/etc/SimpleZramConfig/fstab/backup"

