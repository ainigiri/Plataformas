import meter.*;
import http.requests.*;

Meter meterLight, meterVibration, meterWeight, meterProximity;

void setup(){
  size(700,600);
  background(255,255,200);
  meterLight = new Meter(this, 125, 25, true);
  meterLight.setArcMinDegrees(0.0);
  meterLight.setArcMaxDegrees(360.0);
  meterLight.setDisplayLastScaleLabel(false);
}
