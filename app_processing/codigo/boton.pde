int rquad=40; //Radio del quadrado
int xquad=200;  //Posición X de rect
int yquad=200;  //Posición Y de rect
boolean overRect = false; //Estado del mouse si está encima de rect o no

//Colores del botón
int red=100;
int green=100;
int blue=100;
 
boolean status=false; //Estado del color de rect
String texto="LED OFF";//Texto del status inicial del LED


void mousePressed()  //Cuando el mouse está apretado
{
  if (overRect==true) //Si el mouse está dentro de rect
  {
    status=!status; //El estado del color cambia
    
    if(status==true)
    {
      port.write("{\"Led\":1}\n"); 
      //Color del botón rojo
      red=255;
      green=0;
      blue=0;
      texto="LED ON";
    }
    
    if(status==false)
    {
      
      port.write("{\"Led\":0}\n"); 
      //Color del botón negro
      red=100;
      green=100;
      blue=100;
      texto="LED OFF";
    }
  }
}

void boton(){

  if(mouseX > xquad-rquad && mouseX < xquad+rquad &&  //Si el mouse se encuentra dentro de rect
     mouseY > yquad-rquad && mouseY < yquad+rquad)
     {
       overRect=true;    //Variable que demuestra que el mouse esta dentro de rect
       stroke(255,0,0);  //Contorno de rect rojo
     }
   else
   {
     overRect=false;  //Si el mouse no está dentro de rect, la variable pasa a ser falsa
     stroke(0,0,0);   //Contorno de rect negro
   }
   
  //Dibujamos un rectangulo de color gris
  fill(red,green,blue);
  rectMode(RADIUS); //Esta función hace que Width y Height de rect sea el radio (distancia desde el centro hasta un costado).
  rect(xquad,yquad,rquad,rquad);
   
  //Creamos un texto de color negro con la palabra LED
  fill(0,0,0);
  //PFont f = loadFont("Calibri-48.vlw");//Tipo de fuente
  //textFont(f, 20);
  text(texto, 170, 270);
  
}

void storage(){
  
   //Escribimos los datos de la temperatura con el tiempo (h/m/s) en el archivo de texto
   output.print(valor);
   output.print(" - ");
   output.print(hour( )+":");
   output.print(minute( )+":");
   output.println(second( ));

   output.flush(); // Escribe los datos restantes en el archivo
   println("Storage success");

}
