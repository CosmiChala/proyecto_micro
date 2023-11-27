struct sensor
{
  byte pines;
  int valor;
  bool tipo;
} dispositivos[13];
 //leds (hasta [4]),boton, sonido, 
 //fotodiodo,potenciometro,joystick(visto como dos sensores)
 //boton
byte pin_aparatos[] = {7,2,3,4,5,6,9,11,10,A1,A2,A3,A4};

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
  for(int i = 0; i < 13; i++)
  {
    byte a = dispositivos[i].pines = pin[i];
    pinMode(a, (i < 4)? OUTPUT: INPUT);
    dispositivos[i].tipo = (i < 9)? 1 : 0; //digital : analogico
  }
}


void boton()
{
  int id = 5;
  String nom = "Valor boton: ";
  mandar(id);
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
  int umbral = 800;
  int id = 12;
  mandar(id);
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
  mandar(id);
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
  mandar(id);
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
  for(int i = 8; i < 11; i++)
  {
    if(i == 8)
    {
      mandar(i);
      delay(100);
    }
    else if(i == 9)
    {
      mandar(i);
    }
    else
    {
      mandar(i);
    }
  }
}

void potenciometro()
{
  int id = 11;
  byte etapaAnterior = 0;
  mandar(id);
  for(int i = 1; i < 5; i++)
  {
    if(dispositivos[id].valor != etapaAnterior){digitalWrite(dispositivos[i].pines, LOW);}
    if(dispositivos[id].valor == i){digitalWrite(dispositivos[i].pines,HIGH);}
  }
  etapaAnterior = dispositivos[id].valor;
  //delay(500);
}

void mandar(int i)
{
  if(dispositivos[i].tipo)
  {
    Serial.write((dispositivos[i].valor = digitalRead(dispositivos[i].pines)));
  }
  else
  {
    if(i != 11){Serial.write(dispositivos[i].valor = analogRead(dispositivos[i].pines));}
    else
    {
      dispositivos[i].valor = map(analogRead(dispositivos[i].pines), 0, 1023, 1, 5);
      Serial.write(dispositivos[i].valor);
    }
  }
}
