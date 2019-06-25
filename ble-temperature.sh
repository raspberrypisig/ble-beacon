#!/usr/bin/env bash

#https://stackoverflow.com/questions/25713995/how-to-decode-a-bluetooth-le-package-frame-beacon-of-a-freetec-px-1737-919-b
#https://github.com/NordicSemiconductor/IOS-nRF-Connect/issues/48

# The temperature is expressed in IEEE 11073 floating point structure, which is 3 bytes mantissa data in 2's complement format (i.e. int24), followed by 1 byte of exponent data in 2's complement format (i.e. int8)
# FE -> two complement -> -2 (ie 10^-2 = 0.01 resolution).

while true
do
hcitool cmd 0x08 0x0008 12 02 01 06 06 09 4d 4f 48 41 4e 07 16 09 18 98 08 00 FE 00 00 00 00 00 00 00 00 00 00 00 00 00
sleep 5
done
