import processing.video.*;

color c = color(222);  // Tekstkleur
float x = 0;           // Startpositie x
float y = 125;         // Startpositie y
float dx = 0;          // Verschil in positie x t.o.v. startpositie
float dy = 0;          // Verschil in positie y t.o.v. startpositie
float yThreshold = 67;// Teksthoogte
float xspeed = 8;     // Snelheid x
float yspeed = 1;      // Snelheid y
String s = "HOI ";     // Tekst die getoond wordt
float tw;              // 1 tekstbreedte
int ts = 64;           // Tekstgrootte
Capture video;

void captureEvent(Capture video) {
  video.read();
}

void setup() {
  size(640,480);
  frameRate(30);
  textSize(ts);
  tw = textWidth(s);
  video = new Capture(this, 640, 480);
  video.start();
}

void draw() {
  background(0);
  image(video, 0, 0);
  filter(POSTERIZE,4);
  filter(GRAY);
  filter(BLUR,2);
  filter(ERODE);
  //scroll();
  //display();
}

// Beweeg de text over het scherm, en zet de text terug op de startpositie wanneer het één tekstbreedte of -hoogte is opgeschoven
void scroll() {
  dx = dx + xspeed;
  if (dx >= tw) {
    dx = 0 - tw;
  }
  dy = dy + yspeed;
  if (dy >= yThreshold) {
    dy = 0;
  }
}

// Vul het hele scherm met de text
void display() {
  fill(c);
  //fill(random(255));
  for(int ix = 0; ix < width / tw + 2; ix = ix + 1){
    x = (ix-1) * tw;
      for(int iy = 0; iy < height; iy = iy + 1){
        y = iy * yThreshold; 
        text(s, x + dx, y + dy);
      }
  }
}
