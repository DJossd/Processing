
long tiempo_boton;
String header;
int pos1 = 0, pos2 = 0;

void power_app(String header);

void cliente_udp(void)
{

   int cb = udp.parsePacket();
   if (!cb)
   {
   }
   else
   {

      int len = udp.read(packetBuffer, NTP_PACKET_SIZE);
      String header = (packetBuffer);
      String update = String(packetBuffer);

      //if (millis() > tiempo_boton + TIME_BOTON){

      if (!header.indexOf("/update") >= 0)
      {

         //Serial.println(packetBuffer);
         if (len > 0)
            packetBuffer[len] = 0;
         //Serial.println("IP/Puerto/Tamaño/Mensaje: ");
         //Serial.print(udp.remoteIP());
         //Serial.print("/");
         //Serial.print(udp.remotePort());
         //Serial.print("/");
         //Serial.print(cb);
         //Serial.print("/");
         //Serial.println(packetBuffer);
      }
      ///////////////////////////////////////////////////////////////////
     if (header.indexOf("update=") >= 0){
      pos1 = header.indexOf('=');
      pos2 = header.indexOf('&');
      String PX = header.substring(pos1+1, pos2);
      int posx = PX.toInt();

      int pos3 = header.indexOf('#');
      int pos4 = header.indexOf('$');
      String PY = header.substring(pos3+1, pos4);
      int posy = PY.toInt();

      Serial.printf("posx=%i&#%i$\n", posx, posy);
     }
     
     
      if (header.indexOf("led") >= 0)
      {

         if (led_status == 0)
         {

            led_status = 1;

            valor++;
            digitalWrite(LED_OUT,1);
            Serial.printf("valor=%i&\n", valor);
         }
         else
         {
            digitalWrite(LED_OUT,0);
            led_status = 0;
         }
      }
      power_app(header);

      ///////////////////////////////////////////////////////////////////

      // tiempo_boton = millis();
      //}
      //--------------------------------------------------------------------

      udp.beginPacket(udp.remoteIP(), udp.remotePort());

      udp.printf("%i;%i", power, led_status); //datos de power, pwm dia y pwm noche

      udp.endPacket();
   }

   memset(packetBuffer, 0, NTP_PACKET_SIZE); //clear the buffer to receive the next command
}

void power_app(String header)
{

   if (header.indexOf("/powerOff") >= 0)
   {

      power = 0;
   }

   if (header.indexOf("/powerOn") >= 0)
   {

      power = 1;
   }
}
