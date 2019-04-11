import oscP5.*;
import netP5.*;
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.sensors.*;
import ketai.ui.*;
import android.os.Bundle;
import android.content.Intent;
//import P5ireBase.library.*;

KetaiSensor sensor;
KetaiBluetooth bt;
KetaiList connectionList;
OscP5 oscP5;
NetAddress myRemoteLocation;
//P5ireBase fire;

PVector accelerometer, pAccelerometer;
float tapX, tapY;
float proximity;
float light;
int event;

boolean isCar, isConfiguring;

String UIText;
String info = "";

void setup(){
  orientation(PORTRAIT);
  background(78,83,75);
  stroke(255);
  textSize(48);
  
  bt.start();
  
  UIText = "[b] - hacer este dispositivo visible\n"+
    "[d] - buscar dispositivos\n"+
    "[c] - elegir un dispositivo para conectarse\n"+
    "[p] - listar dispositivos emparejados\n"+
    "[i] - mostrar información del Bluetooth";
  // fire = new P5ireBase(this, "https://plataformas1-ec847.firebaseio.com/");//put here ur DB link created in firebase console
}

void draw(){
  background(78, 93, 75);
  if(isConfiguring){
    ArrayList<String> devices;
    background(34);
    if(key == 'i')
      info = getBluetoothInformation();
    else{
      if(key == 'p'){
        info = "Paired Devices\n";
        devices = bt.getPairedDeviceNames();
      }
      else{
        info = "Discovered Devices:\n";
        devices = bt.getDiscoveredDeviceNames();
      }
      for(int i=0; i < devices.size(); i++){
        info += "["+i+"] " +devices.get(i).toString()+"\n";
      }
    }
    text(UIText + "\n\n" + info, 5, 200);
  }
  else if(isCar){
    OscMessage m = new OscMessage("/infoAuto/");
    background(78,93,75);
    pushStyle();
    fill(255);
    float delta = PVector.angleBetween(accelerometer, pAccelerometer);
    if(degrees(delta) > 45){
      m.add(crashOrSteal());
      m.add(accelerometer.x);
      m.add(accelerometer.y);
      m.add(accelerometer.z);
      oscP5.send(m, myRemoteLocation);
      bt.broadcast(m.getBytes());      
    }
    if(proximity == 0.0){
      m.add(windowLook());
      m.add(proximity);
      oscP5.send(m, myRemoteLocation);
      bt.broadcast(m.getBytes());
    }
    pAccelerometer.set(accelerometer);
    popStyle();
  }
  else{
    background(78,93,75);
    pushStyle();
    switch(event){
      case 0:
        info = "El auto ha sido chocado o se roban las copas del auto\n";
        break;
      case 1:
        info = "El auto está siendo robado\n";
        break;
      case 2:
        info = "Alguien se está asomando por las ventanas del auto\n";
        break;
      case 3:
        info = "Alguien está intentando romper los cristales del auto\n";
        break;
      case 4:
        info = "Alguien está dentro del auto\n";
        break;
      default:
        info = "ERROR\n";
    }
    text(info, 5, 200);
    popStyle();
  }
  drawUI();
}

void onAccelerometerEvent(float x, float y, float z){
  accelerometer.set(x,y,z);
 // fire.setValue("Acelerometro X", accelerometer.x+"");
 // fire.setValue("Acelerometro Y", accelerometer.y+"");
 // fire.setValue("Acelerometro Z", accelerometer.z+"");
}

void onProximityEvent(float v){
  proximity = v;
 // fire.setValue("Proximidad", v+"");
}

void onLightEvent(float v){
  light = v;
 // fire.setValue("Luz", v+"");
}
