# Usage
- Clone this repository
```bash
git clone https://github.com/irdaislakhuafa/SimpleZramConfig.git
```
- Go to repository directory
```bash
cd SimpleZramConfig/
```

- Add executable permission for all script files
```bash
chmod +x * -Rv
```

### Install Zram 
To create zram configuration run this command
```bash
./InstallZram.sh
```
Then you will be asked to enter how many zram devices will be made. You can enter any number depending on your needs, i personally usually only have 1 zram device.
```bash
Number Of Zram Devices : 1
```
Then next you are asked to enter the size of each zram device. there is no special limit for this but usually zram can accommodate up to 3x the size of the original RAM. I use 4GB ram and here i enter the number `12288` (4096 x 3) in MiB format.
```bash
Zram Size (MiB) : 12288
```
Wait until the configuration is complete. Then you are asked to enter the priority of using zram.
default value is 0.

```bash
Set priority for zram0 (default 0 in range -1 to 32767) : 0
```
for simple way you can do this with 1 command 
`InstallZram.sh <needed zram device> <size of zram>`
```bash
./InstallZram.sh 1 1288 

```

## Uninstall Zram
Run this command to uninstall zram configuration
```bash
./UninstallZram.sh 
```