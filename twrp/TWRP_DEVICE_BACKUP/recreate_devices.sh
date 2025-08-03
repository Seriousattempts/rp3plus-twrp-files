#!/system/bin/sh
# Device Node Recreation Script
# Generated from TWRP backup

echo "=== Recreating Device Nodes ==="

mknod "/dev/audio_pipe_bthal" c 0xa 0x2e
chmod 600 "/dev/audio_pipe_bthal"
mknod "/dev/audio_pipe_effect" c 0xa 0x30
chmod 600 "/dev/audio_pipe_effect"
mknod "/dev/audio_pipe_recordproc" c 0xa 0x2f
chmod 600 "/dev/audio_pipe_recordproc"
mknod "/dev/audio_pipe_voice" c 0xa 0x31
chmod 600 "/dev/audio_pipe_voice"
mknod "/dev/snd/comprC0D11" c 0x74 0x1c
chmod 660 "/dev/snd/comprC0D11"
mknod "/dev/snd/comprC0D4" c 0x74 0x1b
chmod 660 "/dev/snd/comprC0D4"
mknod "/dev/snd/controlC0" c 0x74 0x2
chmod 660 "/dev/snd/controlC0"
mknod "/dev/snd/pcmC0D0c" c 0x74 0x4
chmod 660 "/dev/snd/pcmC0D0c"
mknod "/dev/snd/pcmC0D0p" c 0x74 0x3
chmod 660 "/dev/snd/pcmC0D0p"
mknod "/dev/snd/pcmC0D10c" c 0x74 0x11
chmod 660 "/dev/snd/pcmC0D10c"
mknod "/dev/snd/pcmC0D10p" c 0x74 0x10
chmod 660 "/dev/snd/pcmC0D10p"
mknod "/dev/snd/pcmC0D12p" c 0x74 0x12
chmod 660 "/dev/snd/pcmC0D12p"
mknod "/dev/snd/pcmC0D13c" c 0x74 0x13
chmod 660 "/dev/snd/pcmC0D13c"
mknod "/dev/snd/pcmC0D14c" c 0x74 0x14
chmod 660 "/dev/snd/pcmC0D14c"
mknod "/dev/snd/pcmC0D15p" c 0x74 0x15
chmod 660 "/dev/snd/pcmC0D15p"
mknod "/dev/snd/pcmC0D16c" c 0x74 0x16
chmod 660 "/dev/snd/pcmC0D16c"
mknod "/dev/snd/pcmC0D17c" c 0x74 0x17
chmod 660 "/dev/snd/pcmC0D17c"
mknod "/dev/snd/pcmC0D1c" c 0x74 0x6
chmod 660 "/dev/snd/pcmC0D1c"
mknod "/dev/snd/pcmC0D1p" c 0x74 0x5
chmod 660 "/dev/snd/pcmC0D1p"
mknod "/dev/snd/pcmC0D2c" c 0x74 0x7
chmod 660 "/dev/snd/pcmC0D2c"
mknod "/dev/snd/pcmC0D3p" c 0x74 0x8
chmod 660 "/dev/snd/pcmC0D3p"
mknod "/dev/snd/pcmC0D49c" c 0x74 0x19
chmod 660 "/dev/snd/pcmC0D49c"
mknod "/dev/snd/pcmC0D49p" c 0x74 0x18
chmod 660 "/dev/snd/pcmC0D49p"
mknod "/dev/snd/pcmC0D53p" c 0x74 0x1a
chmod 660 "/dev/snd/pcmC0D53p"
mknod "/dev/snd/pcmC0D5c" c 0x74 0xa
chmod 660 "/dev/snd/pcmC0D5c"
mknod "/dev/snd/pcmC0D5p" c 0x74 0x9
chmod 660 "/dev/snd/pcmC0D5p"
mknod "/dev/snd/pcmC0D6c" c 0x74 0xc
chmod 660 "/dev/snd/pcmC0D6c"
mknod "/dev/snd/pcmC0D6p" c 0x74 0xb
chmod 660 "/dev/snd/pcmC0D6p"
mknod "/dev/snd/pcmC0D7p" c 0x74 0xd
chmod 660 "/dev/snd/pcmC0D7p"
mknod "/dev/snd/pcmC0D8c" c 0x74 0xe
chmod 660 "/dev/snd/pcmC0D8c"
mknod "/dev/snd/pcmC0D9c" c 0x74 0xf
chmod 660 "/dev/snd/pcmC0D9c"
mknod "/dev/snd/timer" c 0x74 0x21
chmod 660 "/dev/snd/timer"
mknod "/dev/block/dm-0" b 0xfd 0x0
chmod 600 "/dev/block/dm-0"
mknod "/dev/block/dm-1" b 0xfd 0x1
chmod 600 "/dev/block/dm-1"
mknod "/dev/block/dm-2" b 0xfd 0x2
chmod 600 "/dev/block/dm-2"
mknod "/dev/block/dm-3" b 0xfd 0x3
chmod 600 "/dev/block/dm-3"
mknod "/dev/block/loop0" b 0x7 0x0
chmod 600 "/dev/block/loop0"
mknod "/dev/block/loop1" b 0x7 0x1
chmod 600 "/dev/block/loop1"
mknod "/dev/block/loop10" b 0x7 0xa
chmod 600 "/dev/block/loop10"
mknod "/dev/block/loop11" b 0x7 0xb
chmod 600 "/dev/block/loop11"
mknod "/dev/block/loop12" b 0x7 0xc
chmod 600 "/dev/block/loop12"
mknod "/dev/block/loop13" b 0x7 0xd
chmod 600 "/dev/block/loop13"
mknod "/dev/block/loop14" b 0x7 0xe
chmod 600 "/dev/block/loop14"
mknod "/dev/block/loop15" b 0x7 0xf
chmod 600 "/dev/block/loop15"
mknod "/dev/block/loop2" b 0x7 0x2
chmod 600 "/dev/block/loop2"
mknod "/dev/block/loop3" b 0x7 0x3
chmod 600 "/dev/block/loop3"
mknod "/dev/block/loop4" b 0x7 0x4
chmod 600 "/dev/block/loop4"
mknod "/dev/block/loop5" b 0x7 0x5
chmod 600 "/dev/block/loop5"
mknod "/dev/block/loop6" b 0x7 0x6
chmod 600 "/dev/block/loop6"
mknod "/dev/block/loop7" b 0x7 0x7
chmod 600 "/dev/block/loop7"
mknod "/dev/block/loop8" b 0x7 0x8
chmod 600 "/dev/block/loop8"
mknod "/dev/block/loop9" b 0x7 0x9
chmod 600 "/dev/block/loop9"
mknod "/dev/block/mmcblk0" b 0xb3 0x0
chmod 600 "/dev/block/mmcblk0"
mknod "/dev/block/mmcblk0boot0" b 0xb3 0x8
chmod 600 "/dev/block/mmcblk0boot0"
mknod "/dev/block/mmcblk0boot1" b 0xb3 0x10
chmod 600 "/dev/block/mmcblk0boot1"
mknod "/dev/block/mmcblk0p1" b 0xb3 0x1
chmod 600 "/dev/block/mmcblk0p1"
mknod "/dev/block/mmcblk0p10" b 0x103 0x3
chmod 600 "/dev/block/mmcblk0p10"
mknod "/dev/block/mmcblk0p11" b 0x103 0x4
chmod 600 "/dev/block/mmcblk0p11"
mknod "/dev/block/mmcblk0p12" b 0x103 0x5
chmod 600 "/dev/block/mmcblk0p12"
mknod "/dev/block/mmcblk0p13" b 0x103 0x6
chmod 600 "/dev/block/mmcblk0p13"
mknod "/dev/block/mmcblk0p14" b 0x103 0x7
chmod 600 "/dev/block/mmcblk0p14"
mknod "/dev/block/mmcblk0p15" b 0x103 0x8
chmod 600 "/dev/block/mmcblk0p15"
mknod "/dev/block/mmcblk0p16" b 0x103 0x9
chmod 600 "/dev/block/mmcblk0p16"
mknod "/dev/block/mmcblk0p17" b 0x103 0xa
chmod 600 "/dev/block/mmcblk0p17"
mknod "/dev/block/mmcblk0p18" b 0x103 0xb
chmod 600 "/dev/block/mmcblk0p18"
mknod "/dev/block/mmcblk0p19" b 0x103 0xc
chmod 600 "/dev/block/mmcblk0p19"
mknod "/dev/block/mmcblk0p2" b 0xb3 0x2
chmod 660 "/dev/block/mmcblk0p2"
mknod "/dev/block/mmcblk0p20" b 0x103 0xd
chmod 600 "/dev/block/mmcblk0p20"
mknod "/dev/block/mmcblk0p21" b 0x103 0xe
chmod 600 "/dev/block/mmcblk0p21"
mknod "/dev/block/mmcblk0p22" b 0x103 0xf
chmod 600 "/dev/block/mmcblk0p22"
mknod "/dev/block/mmcblk0p23" b 0x103 0x10
chmod 660 "/dev/block/mmcblk0p23"
mknod "/dev/block/mmcblk0p24" b 0x103 0x11
chmod 600 "/dev/block/mmcblk0p24"
mknod "/dev/block/mmcblk0p25" b 0x103 0x12
chmod 600 "/dev/block/mmcblk0p25"
mknod "/dev/block/mmcblk0p26" b 0x103 0x13
chmod 600 "/dev/block/mmcblk0p26"
mknod "/dev/block/mmcblk0p27" b 0x103 0x14
chmod 600 "/dev/block/mmcblk0p27"
mknod "/dev/block/mmcblk0p28" b 0x103 0x15
chmod 600 "/dev/block/mmcblk0p28"
mknod "/dev/block/mmcblk0p29" b 0x103 0x16
chmod 600 "/dev/block/mmcblk0p29"
mknod "/dev/block/mmcblk0p3" b 0xb3 0x3
chmod 600 "/dev/block/mmcblk0p3"
mknod "/dev/block/mmcblk0p30" b 0x103 0x17
chmod 600 "/dev/block/mmcblk0p30"
mknod "/dev/block/mmcblk0p31" b 0x103 0x18
chmod 600 "/dev/block/mmcblk0p31"
mknod "/dev/block/mmcblk0p32" b 0x103 0x19
chmod 600 "/dev/block/mmcblk0p32"
mknod "/dev/block/mmcblk0p33" b 0x103 0x1a
chmod 600 "/dev/block/mmcblk0p33"
mknod "/dev/block/mmcblk0p34" b 0x103 0x1b
chmod 600 "/dev/block/mmcblk0p34"
mknod "/dev/block/mmcblk0p35" b 0x103 0x1c
chmod 600 "/dev/block/mmcblk0p35"
mknod "/dev/block/mmcblk0p36" b 0x103 0x1d
chmod 600 "/dev/block/mmcblk0p36"
mknod "/dev/block/mmcblk0p37" b 0x103 0x1e
chmod 600 "/dev/block/mmcblk0p37"
mknod "/dev/block/mmcblk0p38" b 0x103 0x1f
chmod 600 "/dev/block/mmcblk0p38"
mknod "/dev/block/mmcblk0p39" b 0x103 0x20
chmod 600 "/dev/block/mmcblk0p39"
mknod "/dev/block/mmcblk0p4" b 0xb3 0x4
chmod 600 "/dev/block/mmcblk0p4"
mknod "/dev/block/mmcblk0p40" b 0x103 0x21
chmod 600 "/dev/block/mmcblk0p40"
mknod "/dev/block/mmcblk0p41" b 0x103 0x22
chmod 600 "/dev/block/mmcblk0p41"
mknod "/dev/block/mmcblk0p42" b 0x103 0x23
chmod 600 "/dev/block/mmcblk0p42"
mknod "/dev/block/mmcblk0p43" b 0x103 0x24
chmod 600 "/dev/block/mmcblk0p43"
mknod "/dev/block/mmcblk0p44" b 0x103 0x25
chmod 600 "/dev/block/mmcblk0p44"
mknod "/dev/block/mmcblk0p45" b 0x103 0x26
chmod 600 "/dev/block/mmcblk0p45"
mknod "/dev/block/mmcblk0p46" b 0x103 0x27
chmod 600 "/dev/block/mmcblk0p46"
mknod "/dev/block/mmcblk0p47" b 0x103 0x28
chmod 600 "/dev/block/mmcblk0p47"
mknod "/dev/block/mmcblk0p48" b 0x103 0x29
chmod 600 "/dev/block/mmcblk0p48"
mknod "/dev/block/mmcblk0p49" b 0x103 0x2a
chmod 600 "/dev/block/mmcblk0p49"
mknod "/dev/block/mmcblk0p5" b 0xb3 0x5
chmod 600 "/dev/block/mmcblk0p5"
mknod "/dev/block/mmcblk0p50" b 0x103 0x2b
chmod 600 "/dev/block/mmcblk0p50"
mknod "/dev/block/mmcblk0p51" b 0x103 0x2c
chmod 600 "/dev/block/mmcblk0p51"
mknod "/dev/block/mmcblk0p52" b 0x103 0x2d
chmod 600 "/dev/block/mmcblk0p52"
mknod "/dev/block/mmcblk0p53" b 0x103 0x2e
chmod 600 "/dev/block/mmcblk0p53"
mknod "/dev/block/mmcblk0p54" b 0x103 0x2f
chmod 600 "/dev/block/mmcblk0p54"
mknod "/dev/block/mmcblk0p55" b 0x103 0x30
chmod 600 "/dev/block/mmcblk0p55"
mknod "/dev/block/mmcblk0p56" b 0x103 0x31
chmod 600 "/dev/block/mmcblk0p56"
mknod "/dev/block/mmcblk0p57" b 0x103 0x32
chmod 600 "/dev/block/mmcblk0p57"
mknod "/dev/block/mmcblk0p58" b 0x103 0x33
chmod 600 "/dev/block/mmcblk0p58"
mknod "/dev/block/mmcblk0p59" b 0x103 0x34
chmod 660 "/dev/block/mmcblk0p59"
mknod "/dev/block/mmcblk0p6" b 0xb3 0x6
chmod 600 "/dev/block/mmcblk0p6"
mknod "/dev/block/mmcblk0p60" b 0x103 0x35
chmod 600 "/dev/block/mmcblk0p60"
mknod "/dev/block/mmcblk0p61" b 0x103 0x36
chmod 600 "/dev/block/mmcblk0p61"
mknod "/dev/block/mmcblk0p62" b 0x103 0x37
chmod 600 "/dev/block/mmcblk0p62"
mknod "/dev/block/mmcblk0p63" b 0x103 0x38
chmod 600 "/dev/block/mmcblk0p63"
mknod "/dev/block/mmcblk0p64" b 0x103 0x39
chmod 600 "/dev/block/mmcblk0p64"
mknod "/dev/block/mmcblk0p65" b 0x103 0x3a
chmod 600 "/dev/block/mmcblk0p65"
mknod "/dev/block/mmcblk0p66" b 0x103 0x3b
chmod 600 "/dev/block/mmcblk0p66"
mknod "/dev/block/mmcblk0p67" b 0x103 0x3c
chmod 600 "/dev/block/mmcblk0p67"
mknod "/dev/block/mmcblk0p68" b 0x103 0x3d
chmod 600 "/dev/block/mmcblk0p68"
mknod "/dev/block/mmcblk0p69" b 0x103 0x3e
chmod 600 "/dev/block/mmcblk0p69"
mknod "/dev/block/mmcblk0p7" b 0xb3 0x7
chmod 600 "/dev/block/mmcblk0p7"
mknod "/dev/block/mmcblk0p70" b 0x103 0x3f
chmod 600 "/dev/block/mmcblk0p70"
mknod "/dev/block/mmcblk0p71" b 0x103 0x40
chmod 600 "/dev/block/mmcblk0p71"
mknod "/dev/block/mmcblk0p72" b 0x103 0x41
chmod 600 "/dev/block/mmcblk0p72"
mknod "/dev/block/mmcblk0p73" b 0x103 0x42
chmod 600 "/dev/block/mmcblk0p73"
mknod "/dev/block/mmcblk0p74" b 0x103 0x43
chmod 600 "/dev/block/mmcblk0p74"
mknod "/dev/block/mmcblk0p75" b 0x103 0x44
chmod 600 "/dev/block/mmcblk0p75"
mknod "/dev/block/mmcblk0p76" b 0x103 0x45
chmod 600 "/dev/block/mmcblk0p76"
mknod "/dev/block/mmcblk0p8" b 0x103 0x1
chmod 600 "/dev/block/mmcblk0p8"
mknod "/dev/block/mmcblk0p9" b 0x103 0x2
chmod 600 "/dev/block/mmcblk0p9"
mknod "/dev/block/mmcblk1" b 0xb3 0x18
chmod 600 "/dev/block/mmcblk1"
mknod "/dev/block/mmcblk1p1" b 0xb3 0x19
chmod 600 "/dev/block/mmcblk1p1"
mknod "/dev/block/pmem0" b 0x103 0x0
chmod 600 "/dev/block/pmem0"
mknod "/dev/block/ram0" b 0x1 0x0
chmod 600 "/dev/block/ram0"
mknod "/dev/block/ram1" b 0x1 0x1
chmod 600 "/dev/block/ram1"
mknod "/dev/block/ram10" b 0x1 0xa
chmod 600 "/dev/block/ram10"
mknod "/dev/block/ram11" b 0x1 0xb
chmod 600 "/dev/block/ram11"
mknod "/dev/block/ram12" b 0x1 0xc
chmod 600 "/dev/block/ram12"
mknod "/dev/block/ram13" b 0x1 0xd
chmod 600 "/dev/block/ram13"
mknod "/dev/block/ram14" b 0x1 0xe
chmod 600 "/dev/block/ram14"
mknod "/dev/block/ram15" b 0x1 0xf
chmod 600 "/dev/block/ram15"
mknod "/dev/block/ram2" b 0x1 0x2
chmod 600 "/dev/block/ram2"
mknod "/dev/block/ram3" b 0x1 0x3
chmod 600 "/dev/block/ram3"
mknod "/dev/block/ram4" b 0x1 0x4
chmod 600 "/dev/block/ram4"
mknod "/dev/block/ram5" b 0x1 0x5
chmod 600 "/dev/block/ram5"
mknod "/dev/block/ram6" b 0x1 0x6
chmod 600 "/dev/block/ram6"
mknod "/dev/block/ram7" b 0x1 0x7
chmod 600 "/dev/block/ram7"
mknod "/dev/block/ram8" b 0x1 0x8
chmod 600 "/dev/block/ram8"
mknod "/dev/block/ram9" b 0x1 0x9
chmod 600 "/dev/block/ram9"
mknod "/dev/block/zram0" b 0xfe 0x0
chmod 600 "/dev/block/zram0"
mknod "/dev/input/event0" c 0xd 0x40
chmod 660 "/dev/input/event0"
mknod "/dev/input/event1" c 0xd 0x41
chmod 660 "/dev/input/event1"
mknod "/dev/input/event2" c 0xd 0x42
chmod 660 "/dev/input/event2"
mknod "/dev/input/event3" c 0xd 0x43
chmod 660 "/dev/input/event3"
mknod "/dev/input/event4" c 0xd 0x44
chmod 660 "/dev/input/event4"
mknod "/dev/input/mice" c 0xd 0x3f
chmod 660 "/dev/input/mice"
mknod "/dev/ashmem" c 0xa 0x2b
chmod 666 "/dev/ashmem"
mknod "/dev/null" c 0x1 0x3
chmod 666 "/dev/null"
mknod "/dev/zero" c 0x1 0x5
chmod 666 "/dev/zero"
mknod "/dev/random" c 0x1 0x8
chmod 666 "/dev/random"
mknod "/dev/urandom" c 0x1 0x9
chmod 666 "/dev/urandom"
mknod "/dev/kmsg" c 0x1 0xb
chmod 600 "/dev/kmsg"
mknod "/dev/ion" c 0xa 0x3f
chmod 600 "/dev/ion"
echo "Device recreation completed!"
