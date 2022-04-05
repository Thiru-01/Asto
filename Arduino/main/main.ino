#include "WiFiClientSecure.h"
#include "ESP8266WiFi.h"
#include "ESP8266HTTPClient.h"
#include "ArduinoJson.h"

#define pin1 5
#define pin2 4
#define onState HIGH
#define offState LOW

const char* ssid = "CANDANE BSNL";

const char* password = "Candane@1324";

const int httpsPort = 443;

const String rest_api_url = "https://asto-b3ec1-default-rtdb.firebaseio.com/.json";

HTTPClient http;

WiFiClientSecure client;

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
  Serial.println(ssid);
  Serial.print("ESP8266 Modüle's IP Adress: ");
  Serial.print(WiFi.localIP());

  delay(2000);

}

void loop() {
 
  FirebaseRequest();
}

void FirebaseRequest(){
 
  client.setInsecure(); 
 
  client.connect(rest_api_url, httpsPort);
  http.begin(client, rest_api_url);
 
  int code = http.GET();
 
  if(code == 200){
    String payload = http.getString();
    DynamicJsonDocument jsonBuffer(1100);
    deserializeJson(jsonBuffer, payload);
    String fan =  jsonBuffer["Rooms"]["room1"]["fan"];
    String light =  jsonBuffer["Rooms"]["room1"]["light"];
    Serial.println(fan);
    digitalWrite(pin1, fan=="LOW"?LOW:HIGH);
    digitalWrite(pin2, light=="LOW"?LOW:HIGH);
    delay(500);
  }  
}
