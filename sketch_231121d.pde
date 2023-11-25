PImage Bayafram, bayas, cha_practice, cha_prin, char_evolve, 
char_muerte, char_volando, char_vvida, fondoBosque, fondoNoche, fondoVuelo, fondoRoca, squirtle, bayaEspecial, pelea, charDuerme;
int x = 200;
int y = 500;
byte i=0;
byte j = 0;
byte etapa = 0;
boolean mostrartexto = true;
byte energia = 0;
int posvx = 1300;
boolean bayaespb = true;
byte p=0;
int possx = 1000;
int possy = 500;
int g =0;
int bayae = 0;
int duracionVuelo = 8000;
int tiempo;
int squirtleTiempoInicio;
int squirtleDuracion = 2000;

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
  charDuerme = loadImage("charDuerme.png");
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
 descanso();
 break;

 case 3:
 volar();
 break;
}
 barrae(1300);
 println(energia);
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
image(cha_prin, mouseX-100, mouseY-100, 220, 200);
  if(dist(mouseX-100, mouseY-100, x, y) < 70){
    x = int(random(0, 1200));
    y = int(random(70, 700));
    i++;
    mostrartexto = false;
  }
  if(i>= 8){
    etapa++;
    mostrartexto = true;
  }
}

void keyPressed(){
   if(key == 'e'){
    etapa++;
   }else if(key == 'n'){
    background(fondoNoche);
    image(charDuerme, 700, 600, 400, 220);
  }
 }

void volar(){
  if(bayae == 5 || key == 'n'){
   tiempo = millis();
   int tiempoTrans = millis() - tiempo;
   if(tiempoTrans < duracionVuelo){
  background(fondoVuelo);
  image(char_volando, mouseX-100, mouseY-100, 220, 200);
  }else{
    background(fondoBosque);
  }
}
}

void mejorar(){
  mostrartexto = true;
  background(fondoRoca);
  image(squirtle, possx, possy, 170, 180);
  image(cha_practice, mouseX-100, mouseY-100, 220, 200);
   if(bayae ==2){
    bayaespecial(200, 500);
    }else if(bayae == 3){
    bayaespecial(700, 500);
  }
  textop("Necesito entrenar con squirtle\n para mejorar", 200, 100, 180, 80);
  if(dist(mouseX-100, mouseY-100, possx, possy) < 90 && key=='p'){ 
      squirtleTiempoInicio = millis();//guardar el tiempo desde que se presiono p
      possx = int(random(0, 1400)); 
      possy = int(random(0, 500));
      j++;
  }
  // checar si squirtle aparecio por la duracion especificada
  if (millis() - squirtleTiempoInicio < squirtleDuracion) {
    image(pelea, 0, 0, 1600, 900);
  }
  key = '0';
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
     etapa++;
  }else{
    textop("Necesito descansar para poder volar.", 200, 80, 250, 60);
  }
  
  
}

void textop(String s, int ancho, int alto, int xc, int yc){
  fill(255,255,255);
  ellipse(mouseX+xc, mouseY-yc, ancho, alto);
  textSize(12);
  fill(0,0,0);
  textAlign(CENTER);
  text(s,mouseX+xc,mouseY-yc);
  fill(255,255,255);
}

void bayaespecial(int w, int z){
  image(bayaEspecial, w, z, 80, 80);
  if(dist(mouseX-100, mouseY-100, w, z) < 100){
    energia++;
    w = 2000;
    z = 2000;
    bayae++;
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
