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


me="$(whoami)"
regexNumber='^[0-9]'
modulesZramConf="zram.conf"
modulesDir="/etc/modules-load.d"
modprobeDir="/etc/modprobe.d"
if [ "$me" == "root" ]; then
    
    # input number of zram devices
    numberOfZramDevices=$1
    
    # if args is empty
    if [ "$numberOfZramDevices" == "" ]; then
        printGreen "Number Of Zram Devices : "
        read numberOfZramDevices
    fi
    
    # if not a number
    if ! [[ $numberOfZramDevices =~ $regexNumber ]]; then
        printlnRed "Not a number!"
        exit 1
    fi
    
    # is value is lower than 1
    if [ $numberOfZramDevices -lt 1 2> /dev/null  ]; then
        printlnRed "Minimum value is 1!"
        exit 1
    fi
    
    
    # input zram size
    zramSize="$2"
    if [ "$zramSize" == "" ]; then
        printGreen "Zram Size (MiB) : "
        read zramSize
    fi
    
    # if not a number
    if ! [[ $zramSize =~ $regexNumber ]]; then
        printlnRed "Not a number!"
        exit 1
    fi
    
    # is value is lower than 1
    if [ $zramSize -lt 1024 2> /dev/null  ]; then
        printlnRed "Minimum value is 1024!"
        exit 1
    fi
    
    
    
    # enable zram modules
    printlnYellow "Enabling zram modules..."
    echo "zram" > "$modulesDir/$modulesZramConf"
    
    # set block devices
    printlnYellow "Setting number of block devices..."
    echo "options zram num_devices=$numberOfZramDevices" > "$modprobeDir/$modulesZramConf"
    
    # set zram size
    udevRulesDir="/etc/udev/rules.d"
    printlnYellow "Setting zram size..."
    
    echo "" > "$udevRulesDir/10-zram.rules"
    for ((i = 0; i < $numberOfZramDevices; i++))
    do
        diskSize=$zramSize"M"
        mkswapLocation="$(command -v mkswap)"
        echo "KERNEL==\"zram$i\", ATTR{comp_algorithm}=\"lz4\", ATTR{disksize}=\"$diskSize\" RUN=\"$mkswapLocation /dev/zram$i\"" >> "$udevRulesDir/10-zram.rules"
    done
    
    # create backup dir
    printlnYellow "Creating backup directory..."
    backupDir="/etc/SimpleZramConfig/fstab/backup"
    
    # if dir not exists
    if ! [ -d "$backupDir" ]; then
        mkdir -p "$backupDir"
    fi
    
    # if fstab backup not exists
    ! test -f "$backupDir/fstab" && cp -r "/etc/fstab" "$backupDir/" && printlnGreen "Success created backup files..." && cp -r "/etc/fstab" "$backupDir/fstab.old"
    
    # save zram config to fstab
    printlnYellow "Saving zram config to fstab..."
    defaultFstab="$(cat $backupDir/fstab)"
    echo "$defaultFstab" > "/etc/fstab"
    for ((i = 0; i < $numberOfZramDevices; i++))
    do
        echo "/dev/zram$i none swap defaults 0 0" >> "/etc/fstab"
    done
    
    
else
    echo "Permission denied, please run as root!"
fi



