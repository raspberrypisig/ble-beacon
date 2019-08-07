
//import 'package:flutter/cupertino.dart';

//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
//import 'package:flutter/widgets.dart';

class LED extends StatelessWidget {
  LED(this.bleDevice);
  final BluetoothDevice bleDevice;

  

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text('LED')
      ),
      body: Container(
        child: LEDPage(bleDevice),
      ),
      
    );
  }

}

class LEDPage extends StatefulWidget {
  LEDPage(this.bleDevice);

  final BluetoothDevice bleDevice;
  @override
  _LEDPageState createState() => _LEDPageState();
  
  }
  
  class _LEDPageState extends State<LEDPage> {
  
  

  void listServices() async {
    List<BluetoothService> services = await widget.bleDevice.discoverServices();
    

    services.forEach((service) {
      String lEDServiceUUID = service.uuid.toString().substring(4,8);
      print(service.uuid.toString());
      print(lEDServiceUUID);
      if (lEDServiceUUID == '1818') {
        print("Service 1818 found.");
        service.characteristics.forEach((BluetoothCharacteristic characterisitic) async {
          String lEDCharacteristicUUID = characterisitic.uuid.toString().substring(4,8).toUpperCase();
          print(characterisitic.uuid.toString());
          if (lEDCharacteristicUUID == '291F'){
              print("about to write to BLE Device");
              await characterisitic.write([0x01,0x00,0x00,0x00], withoutResponse: true);
          }
        });
      }
    });  
  }

  @override
  void initState() {
    super.initState();
    listServices();
  }

  @override
  Widget build(BuildContext context) {
    return Column( 
    
    children: <Widget>[
      
      Text(
      widget.bleDevice.name
    )
    ]);
  }

  }