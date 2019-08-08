
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
  BluetoothCharacteristic ledPrimaryCharacteristic;
  

  void listServices() async {
    List<BluetoothService> services = await widget.bleDevice.discoverServices();
    

    services.forEach((service) {
      String lEDServiceUUID = service.uuid.toString().substring(4,8);
      //print(service.uuid.toString());
      //print(lEDServiceUUID);
      if (lEDServiceUUID == '1818') {
        //print("Service 1818 found.");
        service.characteristics.forEach((BluetoothCharacteristic characterisitic) async {
          String lEDCharacteristicUUID = characterisitic.uuid.toString().substring(4,8).toUpperCase();
          print(characterisitic.uuid.toString());
          if (lEDCharacteristicUUID == '291F'){
              ledPrimaryCharacteristic = characterisitic;
              //print("about to write to BLE Device");
              //await characterisitic.write([0x01,0x00,0x00,0x00], withoutResponse: true);
          }
        });
      }
    });  
  }

  void ledOn() async {
    if (ledPrimaryCharacteristic != null) {
      print("writing 1 to primary characteristic");
      await ledPrimaryCharacteristic.write([0x01,0x00,0x00,0x00], withoutResponse: true);
    }
  }

  void ledOff() async {
    if (ledPrimaryCharacteristic != null) {
      print("writing 0 to primary characteristic");
      await ledPrimaryCharacteristic.write([0x00,0x00,0x00,0x00], withoutResponse: true);
    }
  }

  @override
  void initState() {
    super.initState();
    listServices();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async {
      widget.bleDevice.disconnect();
      //Navigator.of(context).pop();
      return true;
    },  
    child: Center(
      child: Column( 
      
      children: <Widget>[        
        Text(
        widget.bleDevice.name, textScaleFactor: 2,
      ),
      Padding(
        padding: EdgeInsets.only(top: 30.0),
      ),
      RaisedButton(
        onPressed: () async {
           ledOn();
        },
        child: Text('LED ON', style: TextStyle(
          fontSize: 42
        ),),
      ),
      Padding(
        padding: EdgeInsets.only(top: 30.0),
      ),
      RaisedButton(
        onPressed: () async {
          ledOff();
        },
        child: Text('LED OFF', style: TextStyle(
          fontSize: 42
        ),),
      )      
      ]),
    )
    );
  }

  }