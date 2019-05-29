import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

KetaiBluetooth bt;
KetaiList klist;

boolean isConfiguring = true;
boolean rectOver = false;
boolean bReleased = true;
boolean btReceived = false;
int rec = 0;
PFont myFont;
String info = "";

void setup(){
  size(displayWidth, displayHeight);
  smooth();
  frameRate(10);
  orientation(PORTRAIT);
  bt.start();
  isConfiguring = true;
  myFont = createFont("SansSerif", 20);
  textFont(myFont);
}

void draw(){
  if(isConfiguring){
    klist = new KetaiList(this, bt.getPairedDeviceNames());
    isConfiguring = false;
  }
  else{
    color a = color(255,0,0);                      //the color for each button of the interface
    color b = color(255,0,0);
    color c = color(255,0,0);
    color d = color(255,0,0);
    color e = color(165,8,27);
    color f = color(165,8,27);
    color g = color(165,8,27);
    color h = color(165,8,27);
    color i = color(18,21,121);
    color j = color(255,255,255);
    color k = color(255,255,255);
    color l = color(0,0,0);
    byte[] data = new byte[1];
    
    update(mouseX, mouseY);
    background(45,12,137);
    if(btReceived){
      a = color(0);
      b = color(0);
      c = color(0);
      d = color(0);
      e = color(0);
      f = color(0);
      g = color(0);
      h = color(0);
      btReceived = false;
    }
    if(mousePressed && rectOver){
      switch(rec){
        case 1:
          c = color(10,237,26);
          if(bReleased){
            data[0] = 's';
            println("s");
            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 2:
          d = color(10,237,26);
          if(bReleased){
            data[0] = 'w';  
                        println("w");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 3:
          a = color(10,237,26);
          if(bReleased){
            data[0] = 'a'; 
                        println("a");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 4:
          b = color(10,237,26);
          if(bReleased){
            data[0] = 'd'; 
                        println("d");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 5:
          j = color(74,182,252);
          if(bReleased){
            data[0] = 'l';   
                        println("l");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 6:
          k = color(74,182,252);
          if(bReleased){
            data[0] = 'k';     
                        println("k");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 7:
          e = color(10,237,26);
          if(bReleased){
            data[0] = 'q';  
                        println("q");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 8:
          f = color(10,237,26);
          if(bReleased){
            data[0] = 'e';   
                        println("e");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 9:
          g = color(10,237,26);
          if(bReleased){
            data[0] = 'z';              println("z");
    
            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 10:
          h = color(10,237,26);
          if(bReleased){
            data[0] = 'c'; 
                        println("c");

            bt.broadcast(data); 
            bReleased = false; 
          }
          break;
        case 11:
          l = color(255,255,255);
          if(bReleased){
            data[0] = 't';                println("t");
  
            bt.broadcast(data); 
            bReleased = false; 
          }
      }
    }
    if(!mousePressed && rectOver){
      data[0] = ' ';
      bt.broadcast(data);
      bReleased = true;
    }
    
    fill(a);                                                //fill each area of button with the color declared above
    stroke(162); //the shape covered with a grey color line
      triangle(200,250,250,150,300,250);              //draw the triangle with the coordinates
    fill(b);
      triangle(200,600,250,700,300,600);
    fill(c);
      triangle(150,375,50,425,150,475);
    fill(d);
      triangle(350,375,450,425,350,475);
    fill(e);
      triangle(425,240,325,290,400,340);  //325
    fill(f);
      triangle(400,510,325,560,425,610);  //325
    fill(g);
      triangle(75,240,175,290,100,340); //75
    fill(h);
      triangle(100,510,175,560,75,610); //75
    fill(i);
    stroke(172);
      rect(380,80,70,70);                  //draw 2 rectangle below the sphere(ellipse)
      rect(380,700,70,70);
    stroke(0);
    fill(j);
      ellipse(415,115,85,85);            //draw sphere with diameter 85
    fill(k);
      ellipse(415,735,85,85);
    fill(l);
    stroke(255);
      ellipse(25,25,30,30);
  }
  
  fill(255);
  noStroke();
  textAlign(LEFT);
  text(info, 20, 104);
  noFill();
}
