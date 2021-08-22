#include <Arduino.h>
#include <ArduinoJson.h>
#include <Splitter.h>

#include "variables.h"
#include "utilidad.h"
#include "Coneccion_data.h"
#include "Cliente_data.h"
#include "Eeprom_data.h"

bool comandos_rx();

void setup() {

pinMode(LED_OUT, OUTPUT);

  Serial.begin(DEBUGER);
  SerialAT.begin(RASP_BAUD_RATE, SERIAL_8N1, RASP_RX, RASP_TX);

  SerialAT.setTimeout(30); // TIME OUT
  Serial.setTimeout(30);   // TIME OUT

  Serial.print("Timeout AT: ");
  Serial.println(SerialAT.getTimeout()); // print the new value
  Serial.print("Timeout DEBUGER: ");
  Serial.println(Serial.getTimeout()); // print the new value

  Wifi_udp();
  begin_Eeprom();

}

void loop() {
  
  comandos_rx();
  cliente_udp();

}

bool comandos_rx()
{

  bool check;

  DynamicJsonDocument data_doc(2046);

  String comandos = "";

  if (Serial.available())
  {

    while (Serial.available())
    {

      String chat = Serial.readString();
      //String command = Serial.readStringUntil('\n');
      //Serial.println(chat);

      //if (chat != null)
      comandos = "Msg:/" + chat;
    }

    //Serial.println(comandos);

    if (comandos.indexOf("Msg:/") >= 0)
    {

      int pos1 = comandos.indexOf('{');
      int pos2 = comandos.indexOf('}');
      String JSON = comandos.substring(pos1, pos2 + 1);

      Serial.print("Recibe: ");
      Serial.println(JSON);

      //varibales contenedoras
      DeserializationError error = deserializeJson(data_doc, JSON);
      if (error)
      {

        Serial.println("JSON fail.");
        Serial.flush();
        check = false;
      }

      else
      {

        //serializeJsonPretty(data_doc, Serial);
        //serializeJson(data_doc, Serial);
        //Serial.println();

        int led = data_doc["Led"];

        if (led == 1){
          digitalWrite(LED_OUT,1);
          valor++;

          Serial.printf("valor=%i&\n", valor);

        } 
        else  digitalWrite(LED_OUT,0);

        check = true;

      }

      //----------------------
      Serial.flush();
    }
  }

  return check;
}