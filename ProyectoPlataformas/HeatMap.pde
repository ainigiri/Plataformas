void startHeatMaps(){
  image(img, 0, 0, width, height);
  noStroke();
  for(int i = 0; i < rows*cols; i++){
    int x = i%cols;
    int y = i/rows;
    //obteniendo un color en el rango de acuerdo al valor de grid en ese punto
    color c=lerpColor(MINCOL, MAXCOL, map(grid[y][x], 255, 0, 0, 1));
    fill(c,0+grid[y][x]);
    rect(x*width/cols, y*height/rows, width/cols, height/rows);
    if(grid[y][x] > 0){
    //Se reduce el valor de grid para que se "enfrien" los colores
      grid[y][x] -= 0.5;
    }
  }
  noFill();
  stroke(255);
  ellipse(point.x, point.y, 5, 5);
  //enviando valores a firebase
  if(leftEye != null){
    String value = ""+leftEye.x;
    fireLeft.setValue("x", value);
    value = ""+leftEye.y;
    fireLeft.setValue("y", value);
    fireLeft.setValue("open", "true");
  }else{
    fireLeft.setValue("open", "false");
  }
  if(rightEye != null){
    String value = ""+leftEye.x;
    fireRight.setValue("x", value);
    value = ""+leftEye.y;
    fireRight.setValue("y", value);
    fireRight.setValue("open", "true");
  }else{
    fireRight.setValue("open", "false");
  }
}
