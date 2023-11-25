//f volar, c comer, n noche
PImage Bayafram, bayas, cha_practice, cha_prin, char_evolve, 
char_muerte, char_volando, char_vvida, fondoBosque, fondoNoche, fondoVuelo, fondoRoca, squirtle, bayaEspecial, pelea;
int x = 200;
int y = 500;
byte i=0;
byte m = 0;
byte etapa = 0;
boolean mostrartexto = true;
byte energia = 0;
int posvx = 1300;
int w = 300;
int z = 100;
boolean bayaespb = true;
byte p=0;
int possx = 1000;
int possy = 500;
void setup(){
  Bayafram = loadImage("BayaFram.png");
  bayas = loadImage("baya_amarilla.png");
  cha_practice = loadImage("ChaPractice.png");
  cha_prin = loadImage("cha_prin.png");
  char_evolve = loadImage("CharEvolve.png");
  char_volando = loadImage("CharVolando.png");
  char_vvida = loadImage("Charvvida.png");
  fondoBosque = loadImage("FondoBosque.jpg");
  fondoNoche = loadImage("FondoNoche.jpg");
  fondoVuelo = loadImage("Vuelo.jpg");
  fondoRoca = loadImage("fondoRoca2.jpg");
  squirtle = loadImage("squirtle.png");
  bayaEspecial = loadImage("bayaEspecial.png");
  pelea = loadImage("pelea.jpg");
  size(1600, 900);
  noCursor();
}

void draw() {
  switch(etapa){
  case 0: 
  background(fondoBosque);
  image(cha_prin, mouseX-100, mouseY-100, 220, 200);
  bayas();
  break;
  
 case 1: 
 background(fondoRoca);
 image(cha_practice, mouseX-100, mouseY-100, 220, 200);
 mejorar();
 break;
 
 case 2:
 background(fondoRoca);
 image(char_evolve, mouseX-100, mouseY-100, 400, 300);
 break;
 
 case 3:
 background(fondoVuelo);
 image(char_volando, mouseX-100, mouseY-100, 220, 200);
 break;
}
 barrae(1300);
 println(energia);
 
if(m==3){
  background(fondoNoche);
  image(cha_practice, mouseX-100, mouseY-100, 220, 200);
 }else if(m==5){
  volar();
  } 
}

void bayas() {
background(fondoBosque);
image(bayas, x, y, 200,180);
bayaespecial();
if(mostrartexto){
textop("¡Tengo hambre!\n Recoge las bayas para\n alimentarme",130,100);
}

image(cha_prin, mouseX-100, mouseY-100, 220, 200);
  if(dist(mouseX-100, mouseY-100, x, y) < 70){
    x = int(random(0, 1200));
    y = int(random(70, 700));
    i++;
    mostrartexto = false;
  }
 if(i>= 8){
  etapa++;
  m=0;
  }
}

void keyPressed(){
   if(key == 'n'){
    energia++;
  }else if(key == 'p'){
    p=+ 2;
  }else if(key == 'e'){
    etapa++;
  }

 }

void volar(){
  background(fondoVuelo);
  image(char_volando, mouseX-100, mouseY-100, 220, 200);
}

void mejorar(){
  mostrartexto = true;
  background(fondoRoca);
  image(squirtle, possx, possy, 170, 180);
  image(cha_practice, mouseX-100, mouseY-100, 220, 200);
  textop("Necesito tomar la baya\n especial para mejorar", 200, 100);
  if(dist(mouseX-100, mouseY-100, possx, possy) < 90 && key=='p'){ 
      image(pelea, 0,0, 1600,900);
      //possx = int(random(0, 1400)); 
      //possy = int(random(0, 500));
     // key = '0';
  }
}

void textop(String s, int ancho, int alto){
  fill(255,255,255);
  ellipse(mouseX+180, mouseY-80, ancho, alto);
  textSize(12);
  fill(0,0,0);
  textAlign(CENTER);
  text(s,mouseX+180,mouseY-90);
  fill(255,255,255);
}

void bayaespecial(){
  if(bayaespb){
  image(bayaEspecial, w, z, 100, 100);
  }
  if(dist(mouseX-100, mouseY-100, w, z) < 100){
     energia++;
    w = int(random(0, 1200));
    z = int(random(70, 700));
    bayaespb = false;
  }
}

void barrae( int posvx) {
 fill(192,192,192);
 rect(1250, 60, 300, 80, 10);
 for(byte i=0; i<energia; i++){
 fill(102,255,102);
 rect(posvx, 90, 40, 20);
 posvx = posvx+40;
 }
}
