import org.jorgecardoso.processing.eyetribe.*;
import com.theeyetribe.client.data.*;
import java.util.Comparator;
import java.util.Map;
import java.util.Collections;
import P5ireBase.library.*;

final color MINCOL=color(255, 10, 10);
final color MAXCOL=color(10, 10, 255);
EyeTribe eyeTribe;
P5ireBase fireLeft;
P5ireBase fireRight;

ArrayList<PVector> tracking;

PVector calibratingPoint = null;
PVector point;
PVector leftEye, rightEye;
PImage img;

int calibrating = 1;
int calibrationPointInterval = 300;
int calibrationDuration = 1200;
int calibrationStart = 0;
int rows = 20;
int cols = 20;

float grid[][];

String calibrationResult = "Hit space to start calibration.";

void setup(){
  fullScreen();
  img = loadImage("car.png");
  smooth();
  
  tracking = new ArrayList<PVector>();
  grid = new float[rows][cols];
  point = new PVector();
  leftEye = new PVector();
  rightEye = new PVector();
  eyeTribe = new EyeTribe(this, calibrationPointInterval, calibrationDuration);
  fireLeft = new P5ireBase(this, "https://eyeheatmaps.firebaseio.com/leftEye/");
  fireRight = new P5ireBase(this, "https://eyeheatmaps.firebaseio.com/rightEye/");
  PFont font = createFont("", 40);
  textFont(font);
  rectMode(RADIUS);
}

synchronized void draw(){
  background(0);
  checkCalibrationStatus();
}

void keyPressed(){
  if(key == ' '){
    initializeCalibration();
  }
}
