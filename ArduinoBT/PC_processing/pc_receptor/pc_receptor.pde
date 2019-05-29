import processing.serial.*;

Serial myPort;
boolean firstContact = false;

void setup(){
  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw(){
}

void serialEvent(Serial myPort){
  int inByte = myPort.read();
  
  if(!firstContact){
    if(inByte == 'A'){
      myPort.clear();
      firstContact = true;
      myPort.write('A');
    }
  }
  else{
    println(inByte);
  }
}
