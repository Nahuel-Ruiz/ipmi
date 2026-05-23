PImage img1, img2, img3, img4, img5;
PFont fuente;

String texto1 = "AIRBAG\nEl rock argentino que marcó una generación.";
String texto2 = "Mezclando rock clásico con un estilo moderno.";
String texto3 = "La banda evolucionó hacia un sonido más fuerte y emocional.";
String texto4 = "Airbag llenó estadios y conquistó miles de fans\ncon shows cargados de energía y guitarras potentes.";
String texto5 = "AIRBAG SIGUE HACIENDO HISTORIA.";

int diapositiva = -1;
int tiempoCambio;
int duracion = 8000;

//variables para animacion
float tam = 26;
float velocidadTam = 0.15;
float xTexto = -500;
float yTexto = 50;
float alpha = 0;

void setup() {
  size(640, 480);

  fuente = loadFont("Candara-Italic-48.vlw");
  textFont(fuente);

  img1 = loadImage("airbag1.png");
  img2 = loadImage("airbag2.png");
  img3 = loadImage("airbag3.png");
  img4 = loadImage("airbag4.png");
  img5 = loadImage("airbag5.png");
}

void draw() {
  background(0);

  if (diapositiva == -1) {
    image(img1, 0, 0, width, height);
    fill(0, 150);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(42);
    text("AIRBAG", width/2, 150);
    textSize(22);
    text("El monstruo nacional", width/2, 210);

    //boton inicio
    fill(220);
    rect(240, 330, 160, 50, 10);
    fill(0);
    textSize(22);
    text("INICIAR", 320, 355);
  }
  
  //presentacion
  else {
    mostrarFondo();
    fill(0, 120);
    rect(0, 0, width, height);
    
    //pag 1
    if (diapositiva == 0) {
      textAlign(CENTER, CENTER);
      fill(255);
      textSize(tam);
      text(texto1, width/2, height/2);
      tam += velocidadTam;
      
      if (tam > 36 || tam < 26) {
        velocidadTam *= -1;
      }
    }

    //pag 2
    else if (diapositiva == 1) {
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(26);
      text(texto2, xTexto, height/2);
      xTexto += 2;
      
      if (xTexto > 40) {
        xTexto = 40;
      }
    }

    //pag 3
    else if (diapositiva == 2) {
      textAlign(CENTER, CENTER);
      textSize(25);
      fill(255, alpha);
      text(texto3, width/2, height/2);
      
      if (alpha < 255) {
        alpha += 2;
      }
    }

    //pag 4
    else if (diapositiva == 3) {
      textAlign(CENTER, CENTER);
      textSize(24);
      fill(255);
      text(texto4, width/2, yTexto);
      yTexto += 1.2;
      
      if (yTexto > 220 || yTexto < 50) {
        yTexto = 50;
      }
    }

    //pag 5
    else if (diapositiva == 4) {
      textAlign(CENTER, CENTER);
      fill(255);
      textSize(tam);
      text(texto5, width/2, height/2 - 40);
      tam += velocidadTam;
      if (tam > 36 || tam < 26) {
        velocidadTam *= -1;
      }
      //BOTON REINICIAR
      fill(220);
      rect(240, 400, 160, 45, 10);
      fill(0);
      textSize(20);
      text("REINICIAR", 320, 422);
    }
    //transicion 
    if (millis() - tiempoCambio > duracion && diapositiva < 4) {
      diapositiva++;
      tiempoCambio = millis();
    }
  }
}

void mostrarFondo() {
  if (diapositiva == 0) {
    image(img1, 0, 0, width, height);
  }
  else if (diapositiva == 1) {
    image(img2, 0, 0, width, height);
  }
  else if (diapositiva == 2) {
    image(img3, 0, 0, width, height);
  }
  else if (diapositiva == 3) {
    image(img4, 0, 0, width, height);
  }
  else if (diapositiva == 4) {
    image(img5, 0, 0, width, height);
  }
}

void mousePressed() {
  //iniciar
  if (diapositiva == -1 &&
    mouseX > 240 &&
    mouseX < 400 &&
    mouseY > 330 &&
    mouseY < 380) {
    diapositiva = 0;
    tiempoCambio = millis();
  }

  //reiniciar
  if (diapositiva == 4 &&
    mouseX > 240 &&
    mouseX < 400 &&
    mouseY > 400 &&
    mouseY < 445) {
    reiniciarPresentacion();
  }
}

void reiniciarPresentacion() {
  diapositiva = -1;
  tam = 26;
  xTexto = -500;
  yTexto = 50;
  alpha = 0;
}
