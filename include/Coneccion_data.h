#include <WiFi.h>
#include <WiFiUdp.h>
#include <WiFiClient.h>

const byte led = 2;
long udp_test;

unsigned int localPort = 8888;  //Port from which we receive UDP packets
IPAddress myIP;

const int NTP_PACKET_SIZE = 48; // Buffer size for received packets
char packetBuffer[ NTP_PACKET_SIZE]; //Packet storage buffer

WiFiUDP udp;
 
void Wifi_udp (void){

  // We start operations with WIFI
  Serial.print("Configuring access point...");
  Serial.println(ssid);
  
  WiFi.mode(WIFI_OFF); //turn off WIFI
  WiFi.mode(WIFI_AP);  //Put WIFI In Access Point Mode
  WiFi.softAP(ssid, password,11,0); //Run the access point with the given ssid and password on channel 11 (do not interfere with others)

  myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
  Serial.println("HTTP server started");
  Serial.println("Starting UDP");
  udp.begin(localPort); // initialize UDP
  Serial.print("Local port: ");
  Serial.println(localPort);
  udp_test = millis();

}
