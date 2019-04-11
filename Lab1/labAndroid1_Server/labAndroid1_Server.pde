/**
 * Collision (Pong). 
 * 
 * Move the mouse up and down to move the paddle.  
 */
 
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

// Global variables for the ball
float ball_x;
float ball_y;
float ball_dir = 1;
float ball_size = 15;  // Radius
float dy = 0;  // Direction

// Global variables for the paddle
int paddle_width = 10;
int paddle_height = 60;
float paddle_y = 0;
float pPaddle_y = 0;
int paddle_width2=10;
int paddle_height2=60;
float paddle_y2=0;
float pPaddle_y2=0;

int dist_wall = 15;

void setup()
{
  size(640, 360);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  noStroke();
  smooth();
  ball_y = height/2;
  ball_x = width/2;
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("192.168.1.68",12001);
}

void draw() 
{
  background(51);
  
  ball_x += ball_dir * 1.0;
  ball_y += dy;
  if(ball_x > width+ball_size || ball_x < ball_size) {
    ball_x = width/2 - ball_size;
    ball_y = random(0+ball_size, height-ball_size);
    dy = random(-5, 5);
  }
  
  // Constrain paddle to screen
  //paddle_y = constrain(mouseY, paddle_height, height-paddle_height);
  //paddle_y2 = constrain(mouseY, paddle_height2, height-paddle_height2);

  // Test to see if the ball is touching the paddle
  float py = width-dist_wall-paddle_width-ball_size;
  float py2= dist_wall+paddle_width2+ball_size;
  if(ball_x == py 
     && ball_y > paddle_y - paddle_height - ball_size 
     && ball_y < paddle_y + paddle_height + ball_size) {
    ball_dir *= -1;
    if(paddle_y != pPaddle_y) {
      dy = (paddle_y-pPaddle_y)/2.0;
      if(dy >  5) { dy =  5; }
      if(dy < -5) { dy = -5; }
    }
  }
  
  if(ball_x == py2
      && ball_y > paddle_y2 - paddle_height2 - ball_size
      && ball_y < paddle_y2 + paddle_height2 + ball_size){
    ball_dir *= -1;
    if(paddle_y2 != pPaddle_y2){
      dy = (paddle_y-pPaddle_y2)/2.0;
      if(dy > 5){ dy=5;}
      if(dy < -5) {dy=-5;}
    }
  }
  
  // If ball hits paddle or back wall, reverse direction
  //if(ball_x < ball_size && ball_dir == -1) {
   // ball_dir *= -1;
  //}
  
  // If the ball is touching top or bottom edge, reverse direction
  if(ball_y > height-ball_size) {
    dy = dy * -1;
  }
  if(ball_y < ball_size) {
    dy = dy * -1;
  }

  // Draw ball
  fill(255);
  ellipse(ball_x, ball_y, ball_size, ball_size);
  
  // Draw the paddle
  fill(153);
  rect(width-dist_wall, paddle_y, paddle_width, paddle_height);  
  rect(dist_wall, paddle_y2, paddle_width2, paddle_height2);
  pPaddle_y = paddle_y;
  pPaddle_y2 = paddle_y2;
}

void oscEvent(OscMessage theOscMessage){
  print("Cambio recibido");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if(theOscMessage.get(1).floatValue()==1.0){
    paddle_y = theOscMessage.get(0).floatValue();
  }
  else if(theOscMessage.get(1).floatValue()==2.0){
    paddle_y2= theOscMessage.get(0).floatValue();
  }
}
