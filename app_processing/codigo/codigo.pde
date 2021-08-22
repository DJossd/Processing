import processing.serial.*; //Importamos la librería Serial

Serial port; //Nombre del puerto serie
int linefeed = 10;      // ASCII linefeed 

String comandos = "";
int posx;
int posy;
int valor;

float xmag, ymag = 0;
float newXmag, newYmag = 0; 
 
void setup()  { 
  
  println(Serial.list()); //Visualiza los puertos serie disponibles en la consola de abajo
  port = new Serial(this, Serial.list()[1], 115200); //Abre el puerto serie COM3
  //port.bufferUntil(linefeed); 
  port.bufferUntil(10); 
  
  size(640, 360, P3D); 
  noStroke(); 
  colorMode(RGB, 1); 
} 
 
void draw()  { 
  background(0.5);
  
  pushMatrix(); 
  translate(width/2, height/2, -30); 
  
  //newXmag = mouseX/float(width) * TWO_PI;
  //newYmag = mouseY/float(height) * TWO_PI;
  
  newXmag = posy/float(width) * TWO_PI;
  newYmag = posx/float(height) * TWO_PI;
  
  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0; 
  }
  
  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0; 
  }
  
  rotateX(-ymag); 
  rotateY(-xmag); 
  
  scale(90);
  beginShape(QUADS);

  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);

  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);

  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);
  fill(0, 0, 0); vertex(-1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(0, 1, 1); vertex(-1,  1,  1);

  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);

  endShape();
  
  popMatrix(); 
  
  //Visualizamos la temperatura con un texto
  text("Contador =", 510, 300);
  text(valor, 580, 300);
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
  
  
  if (comandos.indexOf("posx=") >= 0)
  {

    int pos1 = comandos.indexOf('=');
    int pos2 = comandos.indexOf('&');
    int pos3 = comandos.indexOf('#');
    int pos4 = comandos.indexOf('$');
    String PX = comandos.substring(pos1+1, pos2);
    String PY = comandos.substring(pos3+1, pos4);
    posx = Integer.valueOf(PX);
    posy = Integer.valueOf(PY);
    
    print("Esp: ");
    print(posx);
    print(" - ");
    println(posy);

    port.clear();
  }
} 

void keyPressed() //Cuando se pulsa una tecla
{

  println ("tecla: " + key);

  //Pulsar la tecla E para salir del programa
  if (key=='e' || key=='E')
  {
    //output.flush(); // Escribe los datos restantes en el archivo
    exit();//Salimos del programa
  }
}
