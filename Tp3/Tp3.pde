//https://youtu.be/LvmO9gEsvK4

PImage imgReferencia; 
color colorBlanco = color(255);
float modificadorMouse = 0;
float anguloRotacion = 0; 

void setup() {
  size(800, 400);
  noStroke();
  
  imgReferencia = loadImage("referencia.jpg"); 
}

void draw() {
  background(100); 

  image(imgReferencia, 0, 0, 400, 400); 

  modificadorMouse = map(mouseX, 400, width, -5, 5);
  
  float distanciaAlCentro = dist(mouseX, mouseY, 600, 200);
  anguloRotacion = map(distanciaAlCentro, 0, 400, radians(15), 0);

  pushMatrix();
  translate(600, 200); 
  rotate(anguloRotacion); 
  
  dibujarIlusionOpArt(0, 0, 380); 
  popMatrix();
}

void dibujarIlusionOpArt(float centroX, float centroY, float tamañoTotal) {
  rectMode(CENTER);
  
  int subdivisiones = 25; 
  float tamañoCelda = tamañoTotal / subdivisiones;

  for (int i = 0; i < subdivisiones; i++) {
    for (int j = 0; j < subdivisiones; j++) {
      
      float posX = centroX - (tamañoTotal/2) + (i * tamañoCelda) + (tamañoCelda/2);
      float posY = centroY - (tamañoTotal/2) + (j * tamañoCelda) + (tamañoCelda/2);
      
      if (debeInvertirColor(i, j, subdivisiones, modificadorMouse)) {
        fill(colorBlanco);
      } else {
        fill(0);
      }
      
      rect(posX, posY, tamañoCelda + 0.5, tamañoCelda + 0.5);
    }
  }
}

boolean debeInvertirColor(int fila, int col, int total, float offset) {
  int centro = total / 2; 
  
  int distCentroX = abs(fila - centro);
  int distCentroY = abs(col - centro);
  int capaConcentrica = max(distCentroX, distCentroY);
  boolean colorBaseEsBlanco = (capaConcentrica % 2 == 1);
  
  int grosorCruz = 2; 
  boolean estaEnCruzHorizontal = (col >= (centro - grosorCruz) && col <= (centro + grosorCruz));
  boolean estaEnCruzVertical = (fila >= (centro - grosorCruz) && fila <= (centro + grosorCruz));
  
  if (estaEnCruzHorizontal && !estaEnCruzVertical) {
    int capaModificada = max(abs((fila + round(offset)) - centro), distCentroY);
    return !(capaModificada % 2 == 1);
  }
  
  if (estaEnCruzVertical && !estaEnCruzHorizontal) {
    int capaModificada = max(distCentroX, abs((col + round(offset)) - centro));
    return !(capaModificada % 2 == 1);
  }
  
  if (estaEnCruzHorizontal && estaEnCruzVertical) {
    return !colorBaseEsBlanco;
  }
  
  return colorBaseEsBlanco; 
}

void mousePressed() {
  colorBlanco = color(random(255), random(255), random(255));
}

void keyPressed() {
  if (key == 'r') {
    colorBlanco = color(255);
    modificadorMouse = 0;
    anguloRotacion = 0;
  }
}
