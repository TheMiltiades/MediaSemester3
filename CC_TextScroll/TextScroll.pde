color c = color(255);
float x = 0;
float y = 100;
float xspeed = 15;
float yspeed = 1;
String s = "HOI";
float tw; 

void setup() {
  size(1080,675);
  frameRate(30);
  textSize(128);
  tw = textWidth(s);
}

void draw() {
  background(0);
  move();
  display();
}

void move() {
  x = x + xspeed;
  if (x > width) {
    x = 0 - tw;
  }
  y = y + yspeed;
  if (y > height + 100) {
    y = 0;
  }
}

void display() {
  fill(c);
  text(s, x, y);
}
