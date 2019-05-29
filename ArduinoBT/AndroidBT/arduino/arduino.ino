#include <SoftwareSerial.h>

#define RX 2
#define TX 3
#define BAUD 9600
#define L_DELAY 1000

SoftwareSerial bt(RX , TX);
const int buttonPin = 4;     
const int ledPin8 =  13;
const int ledPin7 =  12;
const int ledPin6 =  11;
const int ledPin5 =  10;
const int ledPin4 =  9;
const int ledPin3 =  8;
const int ledPin2 =  7;
const int ledPin1 =  6;
bool buttonPress = false;
bool btReceived = false;
 

void setup() {
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  pinMode(ledPin3, OUTPUT);
  pinMode(ledPin4, OUTPUT);
  pinMode(ledPin5, OUTPUT);
  pinMode(ledPin6, OUTPUT);
  pinMode(ledPin7, OUTPUT);
  pinMode(ledPin8, OUTPUT);
  pinMode(buttonPin, INPUT);
  Serial.begin(BAUD);
  bt.begin(BAUD);
}

void loop() {
  char x = '\0';
  buttonPress = digitalRead(buttonPin);

  if (buttonPress == HIGH) {
    bt.println(" 123");
  } else {
    bt.println(" ");    
  }
  
  if(bt.available() > 0){
    x = bt.read();
    btReceived = true;
    Serial.print(x);
  }
  if(btReceived){
    switch(x){
      case 's':
        digitalWrite(ledPin1, HIGH);
        delay(L_DELAY);
        break;
      case 'w':
        digitalWrite(ledPin2, HIGH);
        delay(L_DELAY);
        break;
      case 'a':
        digitalWrite(ledPin3, HIGH);
        delay(L_DELAY);
        break;      
      case 'd':
        digitalWrite(ledPin4, HIGH);
        delay(L_DELAY);
        break;      
      case 'q':
        digitalWrite(ledPin5, HIGH);
        delay(L_DELAY);
        break;
      case 'e':
        digitalWrite(ledPin6, HIGH);
        delay(L_DELAY);
        break;
      case 'z':
        digitalWrite(ledPin7, HIGH);
        delay(L_DELAY);
        break;
      case 'c':
        digitalWrite(ledPin8, HIGH);
        delay(L_DELAY);
        break;
      default:
        digitalWrite(ledPin1, LOW);
        digitalWrite(ledPin2, LOW);
        digitalWrite(ledPin3, LOW);
        digitalWrite(ledPin4, LOW);
        digitalWrite(ledPin5, LOW);
        digitalWrite(ledPin6, LOW);
        digitalWrite(ledPin7, LOW);
        digitalWrite(ledPin8, LOW);
      }
      btReceived = false;
  }
  else{
    digitalWrite(ledPin1, LOW);
    digitalWrite(ledPin2, LOW);
    digitalWrite(ledPin3, LOW);
    digitalWrite(ledPin4, LOW);
    digitalWrite(ledPin5, LOW);
    digitalWrite(ledPin6, LOW);
    digitalWrite(ledPin7, LOW);
    digitalWrite(ledPin8, LOW);
  }
}
