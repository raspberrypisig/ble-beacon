# Mish-mash of BLE Learnings

https://www.silabs.com/community/blog.entry.html/2016/04/25/bluetooth_ble_beacon-IGMb

non-connectable, undirected advertising packets

hciconfig -i hci0 leadv 3

Peripheral sends data ----------> Central consumes data

https://www.accton.com/wp-content/uploads/2018/07/TB_BLE02.jpg

https://www.argenox.com/library/bluetooth-low-energy/ble-advertising-primer/

Advertising packets

Two types:

ADV_IND: Advertising helps with central connecting to peripheral

ADV_NONCONN_IND: advertisement only, no connection solicited (beacon)




Answer

Use type 0xFF(manufacturer-specific data 2bytes)
https://www.silabs.com/community/wireless/bluetooth/knowledge-base.entry.html/2017/11/14/bluetooth_advertisin-zCHh

Use type 0x16 (Service Data)


Advertising data types
https://www.bluetooth.com/specifications/assigned-numbers/generic-access-profile/

List of Services
https://www.bluetooth.com/specifications/gatt/services/

BLE Advertising beacon using Arduino Genuino/101

https://forum.arduino.cc/index.php?topic=476736.0

https://github.com/ElliotMebane/Arduino/tree/master/EddystoneURL_Arduino101
https://github.com/ElliotMebane/Arduino/blob/master/EddystoneUID_Arduino101/EddystoneUID_Arduino101.ino

Service Data(type 0x16)

https://devzone.nordicsemi.com/f/nordic-q-a/4048/what-service-data-can-be-added-to-the-advertising-package

Specification V4
https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=229737




Atmel studio
http://ww1.microchip.com/downloads/en/AppNotes/00002599A.pdf


Bluetooth UUIDS

https://www.bluetooth.com/specifications/assigned-numbers/

Company identifiers
https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/

Bluetooth secure connections
https://www.bluetooth.com/blog/bluetooth-pairing-part-4/

BLE Security
https://medium.com/rtone-iot-security/deep-dive-into-bluetooth-le-security-d2301d640bfc

 
Health Device Profile
https://www.bluetooth.com/specifications/assigned-numbers/health-device-profile/
Glucose Meter
0x1011


profile->services->characteristics

-----------------------------------------------------------------

https://stackoverflow.com/questions/23483086/using-hcitool-to-set-ad-packets

Send BLE packets with hcitool and hciconfig




hciconfig hci0 down 
hciconfig hci0 up
hciconfig hci0 leadv 0
hcitool -i hci0 cmd 0x08 0x0008 0c 0b 09 6c 69 6e 6b 6d 6f 74 69 6f 6e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Hcitool cmd <ogf> <ocf>
0x08 - For the LE Controller Commands, the OGF code is defined as 0x08  
(Bluetooth core spec. 7.8 vol 2 part E)
0x008 - LE Set Advertising Data Command  
Advertising_Data_Length, Advertising_Data
(Bluetooth core spec. 7.8.7 vol 2 part E)
0c:
-----------------
LE Set Advertising Parameters Command  
0x0006

Advertising_Interval_Min,
Advertising_Interval_Max,
Advertising_Type,
Own_Address_Type,
Direct_Address_Type,
Direct_Address,
Advertising_Channel_Map,
Advertising_Filter_Policy
-----------------

----------------
LE Set Scan Response Data Command  
0x0009
----------------

sudo hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 E2 0A 39 F4 73 F5 4B C4 A1 2F 17 D1 AD 07 A9 61 00 00 00 00 C8 00 
sudo hcitool -i hci0 cmd 0x08 0x0009 0c 0b 09 6c 69 6e 6b 6d 6f 74 69 6f 6e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
------------------------------------------------


HCI_Write_Local_Name
0x0013
Local Name
Status

(248 octets, must be terminated by nulls 0x00)
hcitool -i hci0 cmd 0x08 0x0013 41 42 43

--------------
Eddystone
https://stackoverflow.com/questions/38831251/send-eddystone-uid-frame-with-hcitool

https://stackoverflow.com/questions/44425989/sending-eddystone-uid-packet-via-hcitool/46824041#46824041

-------------
https://yencarnacion.github.io/eddystone-url-calculator/


Flags Advertising Data Type
This packet has data type 0x01 indicating various flags. The length is 2 because there are two bytes, the data type and the actual flag value. The flag value has several bits indicating the capabilities of the iBeacon:
Bit0 – Indicates LE Limited Discoverable Mode
Bit1 – Indicates LE General Discoverable Mode
Bit 2 – Indicates whether BR/EDR is supported. This is used if your iBeacon is Dual Mode device
Bit3 – Indicates whether LE and BR/EDR Controller operates simultaneously
Bit4 – Indicates whether LE and BR/EDR Host operates simultaneously


http://bluetooth-dev.blogspot.com/p/blog-page.html

hcidump
gattool

