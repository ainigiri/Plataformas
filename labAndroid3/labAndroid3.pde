import meter.*;
import http.requests.*;

Meter meterLight, meterVibration, meterWeight, meterProximity;
GetRequest get;

float light, vibration, weight, proximity;
String[] sensorList = {"1", "2", "3", "4"};
int sensorNumber = 1;
XML response;

void setup(){
  size(1000,700);
  background(255,255,200);
  
  
  String[] scaleLabels = {"0.0", "0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1.0"};
  
  meterLight = new Meter(this, 15, 5);
  meterLight.setScaleLabels(scaleLabels);
  meterLight.setUp(0, 10, 0.0f, 50.0f, 180.0f, 360.0f);
  meterLight.setTitle("Light Sensor");
  meterLight.setDisplayDigitalMeterValue(true);
  meterLight.updateMeter(0);
  
  meterVibration = new Meter(this, 15, meterLight.getMeterHeight() + 15);
  meterVibration.setScaleLabels(scaleLabels);
  meterVibration.setUp(0, 10, 0.0f, 50.0f, 180.0f, 360.0f);
  meterVibration.setTitle("Vibration Sensor");
  meterVibration.setDisplayDigitalMeterValue(true);
  meterVibration.updateMeter(0);
  
  meterWeight = new Meter(this, meterLight.getMeterX() + meterLight. getMeterWidth() + 25, 10, true);
  meterWeight.setUp(0, 10, 0.0f, 122.0f, 90.0f, 360.0f);
  meterWeight.setScaleLabels(scaleLabels);
  meterWeight.setTitle("Weight Sensor");
  meterWeight.setDisplayDigitalMeterValue(true);
  meterWeight.updateMeter(0);
  
  meterProximity = new Meter(this, meterWeight.getMeterX(), meterWeight.getMeterY() + meterWeight.getMeterHeight() + 10);
  meterProximity.setMeterWidth(340);
  meterProximity.setUp(0, 10, 0.0f, 90.0f, 180.0f, 360.0f);
  meterProximity.setTitle("Proximity Sensor");
  meterProximity.setScaleLabels(scaleLabels);
  meterProximity.setDisplayDigitalMeterValue(true);
  meterProximity.updateMeter(0);
}

void draw(){
  getValues();
  meterLight.updateMeter((int)map(light,0.0,1.0,0.0,10.0));
  meterVibration.updateMeter((int)map(vibration,0.0,1.0,0.0,10.0));
  meterWeight.updateMeter((int)map(weight,0.0,1.0,0.0,10.0));
  meterProximity.updateMeter((int)map(proximity,0.0,1.0,0.0,10.0));
}

void getValues(){
  double[] values = new double[5];
  for (int i = 0; i < values.length; i++){
    get = new GetRequest("http://localhost:8080/fakesensors/fakesensor?param=" + i);
    get.send();
    response = parseXML(get.getContent());
    values[i] = response.getChild("Sensor").getChild("Sensor_Value").getFloatContent();
  }
  light = (float)values[0];
  vibration = (float)values[1];
  weight = (float)values[2];
  proximity = (float)values[3];
}
