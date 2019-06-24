#!/usr/bin/env bash
set -x

sudo hciconfig hci0 up
sudo hciconfig hci0 leadv 3
i=0

while true
do
  val_array=$(echo $i|grep -o .)
  data="00 00 00"
  index=0
  for z in $val_array
  do
    y=$(( $z + 30  ))
    a=$((index * 3)) 
    b=$((2 + $a ))
    data="${data:0:$a}$y${data:$b}"
    index=$((index + 1))
  done
  #first="${data:0:2}"
  #second="${data:3:2}"
  #third="${data:6:2}"
  length1=$(echo $i|wc -c)
  length1=$(( $length1 - 2 + 18))
  #length1=$(( $length1 - 2  + 11 ))
  c=$(echo $i|wc -c)
  c=$((c-2))
  #leg=("09" "0a" "0b")
  leg=("10" "11" "12")
  sudo hcitool -i hci0 cmd 0x08 0x0008 $length1 02 01 06 03 03 aa fe ${leg[c]} 16 aa fe 10 00 02 6a 6f 65 2e 67 6f 6c 64 2f $data 00 00 00 00 00
  #sudo hcitool -i hci0 cmd 0x08 0x0008 $length1 02 01 06 03 03 aa fe ${leg[c]} 16 aa fe 10 00 02 61 00 $data 00 00 00 00 00 00 00 00 00 00 00 00
  echo "The value of i is: $i"
  #echo "The value of data is: $data"
  sleep 5
  i=$(($i + 1))
done
