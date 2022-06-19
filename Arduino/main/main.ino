#include <FirebaseArduino.h> 
#include <FirebaseObject.h>

#include "WiFiClientSecure.h"
#include "ESP8266WiFi.h"
#include "ESP8266HTTPClient.h"
#include "ArduinoJson.h" 
#include <NTPClient.h>
#include <WiFiUdp.h>

#define pin1 5
#define pin2 4
#define onState HIGH
#define offState LOW
#define FIREBASE_AUTH "ppAqtmpLGqlrpvI4G7j39UnjiQ556u3bPvP5h0JO"
#define FIREBASE_HOST "asto-b3ec1-default-rtdb.firebaseio.com"

const char* ssid = "CANDANE BSNL";

const char* password = "Candane@1324";

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(pin1, OUTPUT);
  pinMode(pin2, OUTPUT);
  digitalWrite(pin1, HIGH);
  digitalWrite(pin2, HIGH);
  
  while (WiFi.status() != WL_CONNECTED) 
  {
     delay(200);
     Serial.print("*");
  }
  delay(1000);
  Serial.println("");
  Serial.print("Connected to Wifi ! Network Name: ");
  delay(2000);
  Firebase.begin(FIREBASE_HOST,FIREBASE_AUTH);

}

void loop() {

  
  FirebaseRequest();
}

void FirebaseRequest(){
  
   FirebaseObject obj = Firebase.get("/");
   
}

/*
   digitalWrite(pin1, fan=="LOW"?LOW:HIGH);
    digitalWrite(pin2, light=="LOW"?LOW:HIGH);
*/
 
