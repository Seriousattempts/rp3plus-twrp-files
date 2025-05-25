# How I obtained the files

1. Created a TWRP boot.img (https://www.hovatek.com/twrpbuilder), patched with Magisk v29.0 (https://github.com/topjohnwu/Magisk)
2. Signed with autoroot (https://github.com/skompc/retroid-pocket-3-plus-autoroot)
3. Flashed with Spreadtrum Research Tool (https://drive.google.com/drive/folders/1g9m8BlrCsdzXduEUfDERLilVLzxFQxX8)
4. Boot intro recovery with microsd card with backup2.sd


5. Ran the following commands in Advanced > Terminal
Fix Carriage Returns by removing Windows carriage returns:
- sed -i 's/\r$//' /external_sd/backup2sd.sh
Made the script executable
- chmod +x /external_sd/backup2sd.sh
Ran the Script in TWRP's terminal
- sh /external_sd/backup2sd.sh
