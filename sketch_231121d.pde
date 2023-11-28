//Sensores
import processing .serial.*;
Serial port;
PImage Bayafram, bayas, cha_practice, cha_prin, char_evolve, 
char_muerte, char_volando, fondoBosque, fondoNoche, fondoVuelo, fondoRoca, squirtle, bayaEspecial, pelea, charDuerme, charMuerte, energiaI, instrucciones;
int x = 200;
int y = 500;
int possx = 1000;
int possy = 500;
int bayae = 0;
int squirtleTiempoInicio;
int squirtleDuracion = 2000;
int v = 0;
int d = 0;
int posvx = 1300;
byte i=0;
byte j = 0;
byte etapa = 1;
byte energia = 0;
//byte p=0;
boolean mostrartexto = true;
int datoInt;
int boton, fotoresis, sonido, inclinacion, xj, yj, potenciometro;
int posxj = 800;
int posyj = 400;
boolean instruc = false;
void setup(){
  bayas = loadImage("baya_amarilla.png");
  cha_practice = loadImage("ChaPractice.png");
  cha_prin = loadImage("cha_prin.png");
  char_evolve = loadImage("CharEvolve.png");
  char_volando = loadImage("CharVolando.png");
  fondoBosque = loadImage("FondoBosque.jpg");
  fondoNoche = loadImage("FondoNoche.jpg");
  fondoVuelo = loadImage("Vuelo.jpg");
  fondoRoca = loadImage("fondoRoca2.jpg");
  squirtle = loadImage("squirtle.png");
  bayaEspecial = loadImage("bayaEspecial.png");
  pelea = loadImage("pelea.jpg");
  charDuerme = loadImage("charDuerme.png");
  charMuerte = loadImage("charMuerte.png");
  energiaI = loadImage("energiaI.png");
  instrucciones = loadImage("instrucciones.jpg");
  size(1600, 900);
  noCursor();
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);
  port.bufferUntil('\n');
}

void draw() {
 
  switch(etapa){
    case 1: 
      bayas();
       if(instruc == false){
  image(instrucciones, 200,100, 1200, 700);
  }
      break;
   case 2: 
     mejorar();
     break;
   case 3:
     background(fondoRoca);
     image(char_evolve, posxj-100, posyj-100, 400, 300);
     descanso();
     break;
   case 4:
     volar();
     break;
   case 5:
     background(255,255,255);
     image(charMuerte, 400, 450, 800, 300);
     break;
  }
 barrae(1300);
 if(potenciometro > etapa){
  etapa = byte(potenciometro);
 }
}

void bayas() {
  background(fondoBosque);
  image(bayas, x, y, 200,180);
  if(bayae ==0){
    bayaespecial(200, 500);
    }else if(bayae == 1){
      bayaespecial(700, 500);
  }
  if(mostrartexto){
    textop("¡Tengo hambre!\n Recoge las bayas para\n alimentarme",130,90, 180, 80);
  }
image(cha_prin, posxj-100, posyj-100, 220, 200);
  if(dist(posxj-100, posyj-100, x, y) < 150 && boton == 1){
    x = int(random(0, 1200));
    y = int(random(70, 700));
    i++;
    mostrartexto = false;
  }
  if(i>= 5){
    etapa++;
    mostrartexto = true;
  }
}

void volar(){ 
  background(fondoVuelo);
  image(char_volando, posxj-100, posyj-100, 220, 200);
  if(dist(posxj-100, posyj-100, 800, 450) < 1000){
    v++;
  }
  if(v == 200){
  energia = 4;
  }else if(v == 400){
    energia = 3;
  }else if(v == 600){
    energia = 2;
  }else if(v == 800){
    energia = 1;
  }else if(v == 1000){
    energia = 0;
    etapa++;
  }
}

void mejorar(){
  
  background(fondoRoca);
  image(squirtle, possx, possy, 170, 180);
  image(cha_practice, posxj-100, posyj-100, 220, 200);
   if(bayae ==2){
    bayaespecial(200, 500);
    }else if(bayae == 3){
    bayaespecial(700, 500);
  }
  if(mostrartexto){
  textop("Necesito entrenar con squirtle\n para mejorar", 200, 100, 180, 80);
  }
  if(dist(posxj-100, posyj-100, possx, possy) < 90 && sonido == 1){ 
      squirtleTiempoInicio = millis();//guardar el tiempo desde que se presiono p
      possx = int(random(0, 1400)); 
      possy = int(random(0, 500));
      j++;
      mostrartexto = false;
  }
  // checar si squirtle aparecio por la duracion especificada
  if (millis() - squirtleTiempoInicio < squirtleDuracion) {
    image(pelea, 0, 0, 1600, 900);
  }
  if(j>= 4){
  etapa++;
  j = 0;
  }
}

void descanso(){
   if (bayae == 4){
    bayaespecial(800, 200);
    if(mostrartexto){
    textop("Recoge la última baya especial", 200, 80, 250, 60);
    }
   }else if(bayae == 5){
     etapa = byte(random(4,6));
     print(etapa);
  }else{
    textop("Necesito descansar para poder volar.", 200, 80, 250, 60);
  }
    if(fotoresis <400){
        background(fondoNoche);
        image(charDuerme, 800, 650, 300, 200);
        if(dist(posxj-100, posyj-100, 800, 450) < 2000){
          d++;
        }
        if(d ==250){
          energia = 3;
        }else if(d == 450){
          energia = 5;
        }else if(d == 500){
          etapa++;
        }
     }
   }
  
  

void textop(String s, int ancho, int alto, int xc, int yc){
  fill(255,255,255);
  ellipse(posxj+xc, posyj-yc, ancho, alto);
  textSize(12);
  fill(0,0,0);
  textAlign(CENTER);
  text(s,posxj+xc,posyj-yc);
  fill(255,255,255);
}

void bayaespecial(int w, int z){
  image(bayaEspecial, w, z, 80, 80);
  if(dist(posxj-100, posyj-100, w, z) < 200 && inclinacion == 1){
    energia++;
    w = 2000;
    z = 2000;
    bayae++;
  }
  
}

void barrae( int posvx) {
   fill(192,192,192);
   rect(1250, 60, 300, 80, 10);
   image(energiaI, 1255,80, 40,40);
   for(byte i=0; i<energia; i++){
   fill(102,255,102);
   rect(posvx, 90, 40, 20);
   posvx = posvx+40;
 }
}

void serialEvent(Serial port){
  String datos = port.readStringUntil('\n');
  datos = trim(datos);
  int datosInt = int(datos);
  if(datosInt >=0 && datosInt < 2){
    boton = datosInt;
    println("Boton:"+ boton);
  }else if(datosInt >= 2 && datosInt<1025){
    fotoresis = datosInt-2;
    println("fotoresis: "+ fotoresis);
  }else if(datosInt >= 1026 && datosInt<1028){
    sonido = datosInt-1026;
    println("Sonido:"+ sonido);
  }else if(datosInt >= 1028 && datosInt<1030){
    inclinacion = datosInt-1028;
    println("Inclinacion:"+ inclinacion);
  }else if(datosInt >= 1030 && datosInt<2054){
    xj = datosInt-1030;
     println("Posicion x:"+ xj);
     posxj += map(xj, 502, 1023, 0, 20);
  }else if(datosInt >= 2054 && datosInt<3078){
    yj = datosInt-2054;
     println("Posicion y:"+ yj);
     posyj += map(yj, 509, 1023, 0, 20);
  }else if(datosInt >= 3078 && datosInt<3085){
  potenciometro = datosInt-3078;
  println("Potenciometro:"+ potenciometro);
    }
  }
  
 void keyPressed(){
 if(key =='i'){
  instruc = true;
   }
 }
