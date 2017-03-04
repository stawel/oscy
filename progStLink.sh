#!/bin/bash

set -x

PROGRAMMER=interface/stlink-v2.cfg
TARGET=target/stm32f1x.cfg


HEX=`ls *.hex | head -1`
echo "HEX=$HEX"

function exit_backup()
{
    echo "backup faild!"
    exit 1
}

if [ "$1" != "--no-backup" ]; then
    NOW=`date +"%F_%T"`
    DIR="backup/$NOW"
    echo "creating buckup: $DIR"
    mkdir -p $DIR
    cd $DIR
    openocd -f $PROGRAMMER  -f $TARGET -c "init; dump_image flash_data.bin 0x08000000 0x00010000; shutdown " || exit_backup
    cd -
fi

#openocd -f $PROGRAMMER  -f $TARGET -c "program $HEX verify reset"
