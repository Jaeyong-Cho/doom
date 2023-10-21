#!/usr/bin/env sh

ONEDRIVE="/Users/jaeyong/OneDrive - 아주대학교"
SSD="/Volumes/T7_Touch"
ORG="/Users/jaeyong/Org"

if [ -d "$ONEDRIVE" ] ; then
    rsync -arth "$SSD/Memo/Org" "$ONEDRIVE/Memo"
fi

# if [ -d "$SSD" ] ; then
#     rsync -arth $ORG "$SSD/Memo"
# fi
