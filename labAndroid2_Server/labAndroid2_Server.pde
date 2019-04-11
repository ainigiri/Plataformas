import oscP5.*;
import netP5.*;
import P5ireBase.library.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
P5ireBase fire;

int event;
String info;

float accelerometerX, accelerometerY, accelerometerZ;
float light;
float tapX, tapY;
float proximity;

void setup(){
  size(640,360);
  oscP5 = new OscP5(this,12000);    
  myRemoteLocation = new NetAddress("192.168.43.137",12001);
  textAlign(CENTER,CENTER);
  fire = new P5ireBase(this, "https://plataformas1-ec847.firebaseio.com/");//put here ur DB link created in firebase console

}

void draw(){
  background(51);
  switch(event){
    case 0:
      info = "El auto ha sido chocado o se roban las copas del auto\n";
      fire.setValue("Chocado o roban copas", "true");
      fire.setValue("Robado", "false");
      fire.setValue("Ventanas", "false");
      fire.setValue("Romper Cristales", "false");
      fire.setValue("Dentro auto", "false");
      fire.setValue("Acelerometro X", accelerometerX+"");
      fire.setValue("Acelerometro Y", accelerometerY+"");
      fire.setValue("Acelerometro Z", accelerometerZ+"");
      break;
    case 1:
      info = "El auto está siendo robado\n";
      fire.setValue("Chocado o roban copas", "false");
      fire.setValue("Robado", "true");
      fire.setValue("Ventanas", "false");
      fire.setValue("Romper Cristales", "false");
      fire.setValue("Dentro auto", "false");
      fire.setValue("Acelerometro X", accelerometerX+"");
      fire.setValue("Acelerometro Y", accelerometerY+"");
      fire.setValue("Acelerometro Z", accelerometerZ+"");
      break;
    case 2:
      info = "Alguien se está asomando por las ventanas del auto\n";
      fire.setValue("Chocado o roban copas", "false");
      fire.setValue("Robado", "false");
      fire.setValue("Ventanas", "true");
      fire.setValue("Romper Cristales", "false");
      fire.setValue("Dentro auto", "false");
      fire.setValue("Proximidad", proximity+"");
      break;
    case 3:
      info = "Alguien está intentando romper los cristales del auto\n";
      fire.setValue("Chocado o roban copas", "false");
      fire.setValue("Robado", "false");
      fire.setValue("Ventanas", "true");
      fire.setValue("Romper Cristales", "true");
      fire.setValue("Dentro auto", "false");
      fire.setValue("Golpe X", tapX+"");
      fire.setValue("Golpe Y", tapY+"");
      break;
    case 4:
      info = "Alguien está dentro del auto\n";
      fire.setValue("Chocado o roban copas", "false");
      fire.setValue("Robado", "false");
      fire.setValue("Ventanas", "false");
      fire.setValue("Romper Cristales", "false");
      fire.setValue("Dentro auto", "true");
      fire.setValue("Luz", light+"");
      fire.setValue("Golpe X", tapX+"");
      fire.setValue("Golpe Y", tapY+"");
      break;
    default:
      info = "ERROR\n";
      fire.setValue("Chocado o roban copas", "false");
      fire.setValue("Robado", "false");
      fire.setValue("Ventanas", "false");
      fire.setValue("Romper Cristales", "false");
      fire.setValue("Dentro auto", "false");
  }
  text(info, width/2, height/2);
  
}

void oscEvent(OscMessage m){
  event = m.get(0).intValue();
    switch(event){
    case 0:
      accelerometerX = m.get(1).floatValue();
      accelerometerY = m.get(2).floatValue();
      accelerometerZ = m.get(3).floatValue();
      break;
    case 1:
      accelerometerX = m.get(1).floatValue();
      accelerometerY = m.get(2).floatValue();
      accelerometerZ = m.get(3).floatValue();
      break;
    case 2:
      proximity = m.get(1).floatValue();
      break;
    case 3:
      tapX = m.get(1).intValue();
      tapY = m.get(2).intValue();
      break;
    case 4:
      light = m.get(1).floatValue();
      tapX = m.get(2).intValue();
      tapY = m.get(3).intValue();
  }
}
