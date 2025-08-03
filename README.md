# How I obtained the files

1. Created a TWRP boot.img (https://www.hovatek.com/twrpbuilder), patched with Magisk v29.0 (https://github.com/topjohnwu/Magisk)
2. Signed with autoroot (https://github.com/skompc/retroid-pocket-3-plus-autoroot)
3. Flashed with Spreadtrum Research Tool (https://drive.google.com/drive/folders/1g9m8BlrCsdzXduEUfDERLilVLzxFQxX8)
4. Boot intro recovery with microsd card with backup2.sd
5. Ran the following commands in Advanced > Terminal

Fix Carriage Returns by removing Windows carriage returns:
- sed -i 's/\r$//' /external_sd/backup1sd.sh

Made the script executable
- chmod +x /external_sd/backup###.sh

Ran the Script in TWRP's terminal
- sh /external_sd/backup##.sh

backupsd1 and backupsd2 are different. backupsd2 tries to back up everything, while backupsd1 skips the virtual disks (3 file paths of /dev, /proc, /sys). backupsd3 and backupsd4 are different. 3 tried to take /dev, /proc and /sys which doesn't work. 4 exports into .txt files. The recreate_devices.sh file that is created gives you the device nodes that you can obtain from android's uevent, for android 11 at least.

# A lot of files and folders are missing because of that, along with Github's result of file amounts per upload along with file sizes.
