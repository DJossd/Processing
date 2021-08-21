
import processing.serial.*; //Importamos la librería Serial
 
JSONObject json;

Serial port; //Nombre del puerto serie
int linefeed = 10;      // ASCII linefeed 
 
PrintWriter output;  //Para crear el archivo de texto donde guardar los datos

String comandos = "";
 
 
int xlogo=400;//Posición X de la imagen
int ylogo=50;//Posición Y de la imagen
 
int valor;//Valor de la temperatura
 
//Colores esfera temperatura
float rojo;
float verde;
float azul;
 
void setup()
{
  println(Serial.list()); //Visualiza los puertos serie disponibles en la consola de abajo
  port = new Serial(this, Serial.list()[1], 115200); //Abre el puerto serie COM3
  //port.bufferUntil(linefeed); 
  port.bufferUntil(10); 
  
  output = createWriter("temeratura_datos.txt"); //Creamos el archivo de texto, que es guardado en la carpeta del programa
   
  size(800, 400); //Creamos una ventana de 800 píxeles de anchura por 600 píxeles de altura 

  //json = new JSONObject();

  //json.setInt("id", 0);
  //json.setString("species", "Panthera leo");
  //json.setString("name", "Lion");
  //json.setInt("valor", 1);

  //saveJSONObject(json, "data/new.json");
  
  //println(json);

}
 
void draw()
{
  background(255,255,255);//Fondo de color blanco
    
  boton();
   
  //text("received: " + comandos, 10,50);  
  //Ponemos la imagen de nuestro logo
  //imageMode(CENTER);//Esta función hace que las coordenadas de la imagne sean el centro de esta y no la esquina izquierda arriba
  //PImage imagen=loadImage("logo.jpg");
  //image(imagen,xlogo,ylogo,200,100);
 
 
   //Visualizamos la temperatura con un texto
   text("Contador =",390,200);
   text(valor, 520, 200);
    
   //Escribimos los datos de la temperatura con el tiempo (h/m/s) en el archivo de texto
   //output.print(valor);
   //output.print(hour( )+":");
   //output.print(minute( )+":");
   //output.println(second( ));
   //output.println("");
    
  //Esfera color visualización temperatura
  float temp = map (valor, 0, 100, 0, 255);//Escalamos la temperatura donde maximo sea 100 y mínimo 0
  rojo=temp;
  verde=temp*-1 + 255;
  azul=temp*-1 + 255;
  //Dibujamos una esfera para colorear la temperatura
  noStroke();
  fill(rojo,verde,azul);
  ellipseMode(CENTER);
  ellipse(590,193,20,20);
}
 
void keyPressed() //Cuando se pulsa una tecla
{
  if(key=='w'||key=='W')
  {
        ylogo--; //El logo se deplaza hacia arriba
  }
  else if(key=='s'||key=='S')
  {
        ylogo++; //El logo se deplaza hacia abajo
  }
  else if(key=='a'||key=='A')
  {
        xlogo--; //El logo se desplaza hacia la izquierda
  }
  else if(key=='d'||key=='D')
  {
        xlogo++; //El logo se desplaca hacia la derecha
  }
  //Pulsar la tecla E para salir del programa
  if(key=='e' || key=='E')
  {
    output.flush(); // Escribe los datos restantes en el archivo
    output.close(); // Final del archivo
    exit();//Salimos del programa
  }
}

void serialEvent(Serial port) { 
  
  comandos = port.readString(); 
  println(comandos);
  
  if (comandos.indexOf("valor=") >= 0)
  {

      int pos1 = comandos.indexOf('=');
      int pos2 = comandos.indexOf('&');
      String JSON = comandos.substring(pos1+1, pos2);
      valor = Integer.valueOf(JSON);
      
      print("Esp: ");
      println(JSON);
      
  port.clear();
  }
} 
