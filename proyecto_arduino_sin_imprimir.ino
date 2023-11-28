struct sensor
{
  byte pines;
  int valor;
  bool tipo;
} dispositivos[12];
 //leds (hasta [4]),boton, sonido, 
 //fotodiodo,potenciometro,joystick(visto como dos sensores)
 //boton
byte pin_aparatos[] = {7,2,3,4,5,6,9,11,A1,A2,A3,A4};

void setup() 
{ 
  Serial.begin(9600);
  creaSensor(pin_aparatos);
}

void loop() {
  //enviar estado de dispositivos
  boton();
  fotoresistencia();
  sonido();
  inclinacion();
  joystick();
  potenciometro();
}

struct sensor creaSensor(byte* pin)
{
  for(int i = 0; i < 12; i++)
  {
    byte a = dispositivos[i].pines = pin[i];
    pinMode(a, (i < 4)? OUTPUT: INPUT);
    dispositivos[i].tipo = (i < 8)? 1 : 0; //digital : analogico
  }
}


void boton()
{
  int id = 5;
  int suma = 0;
  String nom = "Valor boton: ";
  mandar(id, suma);
  if (dispositivos[id].valor)
  {
    //delay (500); 
    digitalWrite(dispositivos[0].pines, HIGH);
  }
  else
  {
    //delay(500);
    digitalWrite(dispositivos[0].pines, LOW);
  }
  delay (1000);
}

void fotoresistencia ()
{
  int umbral = 100;
  int id = 11;
  int suma = 2;
  mandar(id, suma);
  if(dispositivos[id].valor < umbral)
  {
    //delay (500);
    digitalWrite(dispositivos[0].pines, HIGH);
  }
  else
  {
    delay (500);
    digitalWrite(dispositivos[0].pines, LOW);
  }
  delay(1000);
}

void sonido()
{
  int id = 6;
  int suma = 1026;
  mandar(id, suma);
  if (dispositivos[id].valor)
  {
    //delay (500);
    digitalWrite(dispositivos[0].pines, HIGH);
  } 
  else 
  {
    //delay (500);
    digitalWrite(dispositivos[0].pines, LOW);
  }
  delay(1000);
}

void inclinacion()
{
  int id = 7;
  int suma = 1028;
  mandar(id, suma);
  if(dispositivos[id].valor)
  {
    delay(50);
    if(dispositivos[id].valor)
    {
      digitalWrite(dispositivos[0].pines, HIGH);
    }
  }
  else
  {
    delay(50);
    if(!dispositivos[id].valor)
    {
      digitalWrite(dispositivos[0].pines, LOW);
    }
  }
  delay(500);
}

void joystick()
{
  for(int i = 8; i < 10; i++)
  {
    if(i == 8)
    {
      int suma = 1030;
      mandar(i, suma);
      delay(100);
    }
    else if(i == 9)
    {
      int suma = 2054;
      mandar(i, suma);
    }
  }
}

void potenciometro()
{
  int id = 10;
  byte etapaAnterior = 0;
  int suma = 3078;
  mandar(id, suma);
  for(int i = 1; i < 5; i++)
  {
    if(dispositivos[id].valor != etapaAnterior){digitalWrite(dispositivos[i].pines, LOW);}
    if(dispositivos[id].valor == i){digitalWrite(dispositivos[i].pines,HIGH);}
  }
  etapaAnterior = dispositivos[id].valor;
  //delay(500);
}

void mandar(int i, int suma)
{
  if(dispositivos[i].tipo)
  {
    Serial.println((dispositivos[i].valor = digitalRead(dispositivos[i].pines)) + suma);
  }
  else
  {
    if(i != 11){Serial.println((dispositivos[i].valor = analogRead(dispositivos[i].pines))+suma);}
    else
    {
      dispositivos[i].valor = map(analogRead(dispositivos[i].pines), 0, 1023, 1, 5);
      Serial.println(dispositivos[i].valor + suma);
    }
  }
}


