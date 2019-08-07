package com.example.bleled;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.bluetooth.BluetoothAdapter;
import android.content.Intent;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.mohankumargupta.bleled/helper";
  private final static int REQUEST_ENABLE_BT = 1;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall call, Result result) {
              if (call.method.equals("enableBluetooth")) {
                BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
                if (!mBluetoothAdapter.isEnabled()) {
                  Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                  startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT);
                }
              }  

              if (call.method.equals("disableBluetooth")) {
                BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
                if (mBluetoothAdapter.isEnabled()){
                  mBluetoothAdapter.disable();
                }
              }
          }
      });

  }

  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if(requestCode==REQUEST_ENABLE_BT && resultCode==RESULT_CANCELED){
             
    }
}

}
