final String REN=P2D;
 
PGraphics fg;
PGraphics bg;
boolean maskImageNow=true;
 
PImage city;
PImage gnome;

void settings() {
  city=loadImage("city.png");
  size(city.width, city.height, REN);
  smooth(8);
}
 
void setup() {
  ellipseMode(RADIUS);
  gnome=loadImage("gnom.png");
 
  fg = createGraphics(width, height, REN);
 
  bg=createGraphics(width, height, REN);
  bg.beginDraw();  
  bg.noFill();
  bg.stroke(255);
  bg.strokeWeight(2);
  bg.clear();
  bg.image(gnome, 0, 0);
  bg.endDraw();
}

void draw() {
  image(city, 0, 0);
 
  fg.beginDraw();
  fg.clear();
  fg.ellipse(mouseX, mouseY, 100, 100);
  fg.endDraw();
 
  if (maskImageNow) {
    bg.mask(fg);
    image(bg, 0, 0);
  }
}
 
void keyReleased() {
}
 
void mouseReleased() {
  maskImageNow=!maskImageNow;  //Toggle action
}
