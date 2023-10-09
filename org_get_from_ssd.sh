#!/usr/bin/env sh

SSD="/Volumes/T7_Touch"
ORG="/Users/jaeyong"

if [ -d "$SSD" ] ; then
    rsync -arth "$SSD/Memo/Org" $ORG
fi
