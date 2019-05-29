import oscP5.*;
import netP5.*;
import ketai.net.*;
import ketai.sensors.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
KetaiSensor sensor;

float accelerometerX, accelerometerY, accelerometerZ;

void setup(){
  sensor = new KetaiSensor(this);
  oscP5 = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress("192.168.1.76",12000);
  sensor.start();
}

void draw(){
  background(0);
  OscMessage myMessage= new OscMessage("accelerometerData");
  myMessage.add(map(accelerometerX,-10,10,0,360));
  myMessage.add(1.0);
  oscP5.send(myMessage, myRemoteLocation);
}

void onAccelerometerEvent(float x, float y, float z){
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}
