void update(int x, int y){
  if ( overRect(200, 150, 100, 100) ) {
    rectOver = true;                   //left right
    rec = 3;
  }
  else if( overRect(50, 375, 100, 100) ) {
    rectOver = true;                   //up down
    rec = 1;
  }
  else if( overRect(350, 375, 100, 100) ) {
    rectOver = true;
    rec = 2;                            //up down
  }
  else if( overRect(200, 600, 100, 100) ) {
    rectOver = true;                   //left right
    rec = 4;
  }
  else if( overRect(372,72,85,85) ) {
    rectOver = true;
    rec = 5;                            //for ellipse 1
  }
  else if( overRect(372,692,85,85) ) {
    rectOver = true;
    rec = 6;                            //for ellipse 2
  }
  else if( overRect(325, 240, 100, 100) ) {
    rectOver = true;
    rec = 7;                            //up left
  }
  else if( overRect(325, 510, 100, 100) ) {
    rectOver = true;
    rec = 8;                            //up right
  }
  else if( overRect(75, 240, 100, 100) ) {
    rectOver = true;
    rec = 9;                            //btm left
  }
  else if( overRect(75, 510, 100, 100) ) {
    rectOver = true;
    rec = 10;                          //btm right
  }
  else if( overRect(10, 10, 30, 30) ) {
    rectOver = true;
    rec = 11;                          //stop
  }
  else{
    rectOver = false;                 //nothing s touched on screen
  }
}

boolean overRect(int x, int y, int width, int height)  { // to scan we touch which area
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height){             //to see if the mouse cursor inside rect
    return true;
  }
  else {
    return false;
  }
}
