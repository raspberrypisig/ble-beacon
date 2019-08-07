import 'package:flutter/material.dart';
import 'dart:io';
//import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'led.dart';
//import 'package:android_intent/android_intent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE LED Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: MyHomePage(title: 'BLE LED Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('com.mohankumargupta.bleled/helper');
  int _counter = 0;
  final List<String> bleDevices = ["One", "Two"];
  bool isBluetoothOn = false;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  
  void enableBluetooth() async {
    if (Platform.isAndroid) {
      await platform.invokeMethod('enableBluetooth');
    }
  }

  void disableBluetooth() async {
    if (Platform.isAndroid) {
    await platform.invokeMethod('disableBluetooth');
    }
  }
    
  @override
  void initState() {
    super.initState();
    enableBluetooth();
  }
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Row(
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16.0)
                  ),
                  Text("BLUETOOTH STATUS: ", textScaleFactor: 1.3, ),
                  StreamBuilder<BluetoothState>(
                    stream: flutterBlue.state,
                    initialData: BluetoothState.off,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      final state = snapshot.data;
                      if (state == BluetoothState.on) {
                         isBluetoothOn = true;
                      }
                      if (state == BluetoothState.off) {
                         isBluetoothOn = false;
                      }

                      return Switch(
                        onChanged: (bool value) {
                          setState(() {
                            isBluetoothOn = value;  
                          });
                          value ? enableBluetooth() : disableBluetooth();
                        }, 
                        value: isBluetoothOn,
                      );
                    },
                  )
                ]),
              ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 MaterialButton(
                   splashColor: Colors.redAccent,
                   child: Text("SCAN", style: TextStyle(
                     color: Colors.blueAccent,
                     fontSize: 20.0
                   ),),
                   onPressed: () {
                     flutterBlue.startScan();
                   },

                 )
               ],
             ),
             Padding(
               padding: EdgeInsets.only(bottom: 20),
             ),
             Container(
               width: double.infinity,
               padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
               color: Color.fromRGBO(211,211, 211, 1),
               child: Text("BLE Devices", textAlign: TextAlign.center),
             )
             ,
             Padding(
               padding: EdgeInsets.only(bottom: 10)
             ),
             Divider(),
             Expanded(
               child: StreamBuilder<List<ScanResult>>(
                 stream: FlutterBlue.instance.scanResults,
                 initialData: [],
                 builder: (BuildContext context, AsyncSnapshot snapshot) {
                   
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     
                     children: snapshot.data.map<Widget>(
                       (ScanResult r) {
                        if (r.device.name != "") { 
                         return
                         GestureDetector(
                         onTap: () async {
                           print(r.device.name);
                           await r.device.connect();
                           Navigator.push(
                             context, 
                             MaterialPageRoute(
                               builder: (BuildContext context) {
                                 flutterBlue.stopScan();
                                 return  LED(r.device);
                               }
                             )
                           );
                         }, 
                         child: Column(  
                           crossAxisAlignment: CrossAxisAlignment.stretch,                        
                           children: <Widget>[Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           mainAxisSize: MainAxisSize.max,
                           children: <Widget>[
                           //Text(r.device.id.toString(), textScaleFactor: 1.3,),
                           //Text(":"),
                             Padding(
                             padding: EdgeInsets.only(top: 50.0),
                           ),
                           Text(r.device.name, textScaleFactor: 1.5,),
                           Padding(
                             padding: EdgeInsets.only(bottom: 50.0),
                           )
                         ],
                       ), 
                        
                       Divider(),
                       ]
                       ));
                       }
                       return Container(width: 0, height: 0);
                       }
                     ).toList()
                       
                   );
                 },
               ),
             )
          ],
        ),
      ), 
    );
  }



}
