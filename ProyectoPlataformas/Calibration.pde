synchronized void calibratingPoint(PVector p, boolean start){
  if(start){
    println("Calibrating point: " + p);
    calibratingPoint = p.get();
    calibrationStart = millis();
  }else{
    println("Done with " + p);
    calibratingPoint = null;
  }
}

void calibrationEnded(boolean result, double acc, double accRight, double accLeft, CalibrationResult calibResult) {
  calibrating = 0;
  println("Result: " + result + " " + acc);

  if ( result ) {
    calibrationResult = "Calibration Result: ok. " + rate(acc);
  } else {
    calibrationResult = "Calibration failed, try again.";
  }
}

synchronized void onGazeUpdate(PVector gaze, PVector leftEye_, PVector rightEye_, GazeData data) {
  //println(eyeTribe.isTracking() + " " + eyeTribe.isTrackingGaze() + " " + eyeTribe.isTrackingEyes() + " " + data.stateToString());
  if ( gaze != null ) {
    point = gaze;
    tracking.add(point.get());
    if (tracking.size() > 500 ) {
      tracking.remove(0);
    }
    if(calibrating == 0){
      point = gaze.get();
      int x = (int)constrain(round(map(point.x, 0, width, 0, cols-1)), 0, cols-1);
      int y = (int)constrain(round(map(point.y, 0, height, 0, rows-1)), 0, rows-1);
      
      grid[y][x] = constrain(grid[y][x]+10, 0, 255);
    }
  }

  leftEye = leftEye_;

  rightEye = rightEye_;
}

void trackerStateChanged(String state) {
  println("Tracker state: " + state);
}

String rate(double accuracy) {
  if (accuracy < 0.5)
    return "Calibration Quality: PERFECT";

  if (accuracy < 0.7)
    return "Calibration Quality: GOOD";

  if (accuracy < 1)
    return "Calibration Quality: MODERATE";

  if (accuracy < 1.5)
    return "Calibration Quality: POOR";

  return "Calibration Quality: REDO";
}

void checkCalibrationStatus(){
  if(calibrating == 0){
    startHeatMaps();
  }else if (calibrating == 1){
    if ( leftEye != null ) {
      fill(255);
      stroke(0);
      ellipse(leftEye.x*width, leftEye.y*height, 60, 30);

      fill(#1A78D3);
      ellipse(leftEye.x*width, leftEye.y*height, 20, 20);

      fill(0);
      ellipse(leftEye.x*width, leftEye.y*height, 7, 7);
    }
    if ( rightEye != null ) {
      fill(255);
      stroke(0);
      ellipse(rightEye.x*width, rightEye.y*height, 60, 30);

      fill(#1A78D3);
      ellipse(rightEye.x*width, rightEye.y*height, 20, 20);

      fill(0);
      ellipse(rightEye.x*width, rightEye.y*height, 7, 7);
    }
    noFill();
    stroke(255, 0, 0);
    ellipse(point.x, point.y, 30, 30);
    
    if ( tracking.size() > 1) {
      for (int i = 1; i < tracking.size (); i++ ) {
        stroke(map(i, 1, tracking.size(), 0, 255));
        strokeWeight(map(i, 1, tracking.size(), 0.1, 3));
        PVector f = tracking.get(i-1);
        line(f.x, f.y, tracking.get(i).x, tracking.get(i).y);
      }
    }
    fill(255);
    text("Hit space again, and follow the circles...", width/2-textWidth("Hit space again, and follow the circles...")/2, height/2);
    calibrationResult = "";  
  } else{
    if (calibratingPoint != null){
      fill(255);
      noStroke();
      float s = map(millis(), calibrationStart, calibrationStart+calibrationDuration, 40, 20);
      ellipse(calibratingPoint.x, calibratingPoint.y, s, s);
      fill(0, 0, 0);
      s = map(millis(), calibrationStart, calibrationStart+calibrationDuration, 1, 7);
      ellipse(calibratingPoint.x, calibratingPoint.y, s, s);
    }
  }
  
  fill(255);
  text(calibrationResult, 100, height-100);
}

void initializeCalibration(){
    calibrating++;
    if(calibrating > 2) calibrating = 0;
    if(calibrating == 2) {
      ArrayList<PVector> points = new ArrayList<PVector>();
      int COLS = 3;
      int ROWS = 3;
      int MARGIN = 200;
      for(int x = 0; x < COLS; x++){
        for(int y = 0; y < ROWS; y++){
          points.add(new PVector(map(x, 0, COLS-1, MARGIN, width-MARGIN),
                                  map(y, 0, ROWS-1, MARGIN, height-MARGIN)));
        }
      }
      Collections.shuffle(points);
      PVector calP[] = points.toArray(new PVector[points.size()]);
      eyeTribe.calibrate(calP);
    }
}
