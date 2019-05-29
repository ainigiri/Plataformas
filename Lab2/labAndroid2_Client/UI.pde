void mousePressed(){
 // fire.setValue("Mouse X", mouseX+"");
 // fire.setValue("Mouse Y", mouseY+"");
  if (mouseY <= 100 && mouseX > 0 && mouseX < width/3){
    if(isCar){
      isCar=false;
      if(sensor.isStarted())
        sensor.stop();
    }
    KetaiKeyboard.show(this);
    isConfiguring = true;// 1
  }
  else if (mouseY <= 100 && mouseX > width/3 && mouseX < 2*(width/3)){
    if (isConfiguring){
      KetaiKeyboard.hide(this);
      isConfiguring = false;
    }
    isCar=true; // 2
    sensor = new KetaiSensor(this);
    oscP5 = new OscP5(this, 12001);
    myRemoteLocation = new NetAddress("192.168.43.46",12000);
    if(!sensor.isStarted())
      sensor.start();
    accelerometer = new PVector();
    pAccelerometer = new PVector();
  }
  else if (mouseY <= 100 && mouseX >  2*(width/3) && mouseX < width){
    if (isConfiguring){
      KetaiKeyboard.hide(this);
      background(78, 93, 75);
      isConfiguring=false;
    }
    if (isCar){
      background(78, 93, 75);
      isCar = false;
      if(sensor.isStarted())
        sensor.stop();
    }
  }
  if(isCar){
    OscMessage m = new OscMessage("/infoAuto/");
    if(light<20){
      m.add(insideCar());
      m.add(light);
      m.add(mouseX);
      m.add(mouseY);
      oscP5.send(m, myRemoteLocation);
      bt.broadcast(m.getBytes());
    }
    else{
      m.add(windowBreak());
      m.add(mouseX);
      m.add(mouseY);
      oscP5.send(m, myRemoteLocation);
      bt.broadcast(m.getBytes());
    }
  }
}

void keyPressed(){
  if(key == 'c'){
    if(bt.getDiscoveredDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getDiscoveredDeviceNames());
    else if(bt.getPairedDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getPairedDeviceNames());      
  }
  else if(key == 'd')
    bt.discoverDevices();
  else if(key == 'b')
    bt.makeDiscoverable();
}

void drawUI(){
  pushStyle();
  stroke(255);
  
  if(isConfiguring){
    noStroke();
    fill(78,93,75);
  }
  else
    fill(0);
  rect(0, 0, width/3, 100);
  
  
  if(isCar){
    noStroke();
    fill(78,93,75);
  }
  else{
    fill(0);
    stroke(255);
  }
  rect(width/3, 0, width/3, 100);

  if(!isConfiguring && !isCar){
    noStroke();
    fill(78,93,75);
  }
  else{
    fill(0);
    stroke(255);
  }  
  rect((width/3)*2, 0, width/3, 100);

  fill(255);
  text("Bluetooth", 5, 70);
  text("Car", width/3 + 5, 70);
  text("Owner", width/3*2 + 5, 70);
  popStyle();
}

void onKetaiListSelection(KetaiList connectionList){
  String selection = connectionList.getSelection();
  bt.connectToDeviceByName(selection);
  connectionList = null;
}
