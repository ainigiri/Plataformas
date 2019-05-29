#include <SoftwareSerial.h>
#define RX 10
#define TX 11

SoftwareSerial bt(RX, TX);
int inByte = 0;
int inBt = 0;
bool btReceived = false;

void setup() {
  Serial.begin(9600);
  bt.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  establishContact();
}

void loop() {
  if(Serial.available() > 0){
    inByte = Serial.read();
    if(bt.available() > 0){
      inBt = bt.read();
      btReceived = true;
    }
    if(btReceived){
      Serial.write(inBt);
      btReceived = false;
    }
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
