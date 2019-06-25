#!/usr/bin/env bash

#https://stackoverflow.com/questions/25713995/how-to-decode-a-bluetooth-le-package-frame-beacon-of-a-freetec-px-1737-919-b
#https://github.com/NordicSemiconductor/IOS-nRF-Connect/issues/48

while true
do
hcitool cmd 0x08 0x0008 12 02 01 06 06 09 4d 4f 48 41 4e 07 16 09 18 98 08 00 FE 00 00 00 00 00 00 00 00 00 00 00 00 00
sleep 5
done
