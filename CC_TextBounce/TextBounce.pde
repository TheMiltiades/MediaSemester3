color c = color(255);
float x = 0;
float y = 100;
float xspeed = 75;
float yspeed = 50;
String s = "HOI";
float tw; 

void setup() {
  size(900,900);
  frameRate(30);
  textSize(128);
  textAlign(CENTER);
  tw = textWidth(s);
}

void draw() {
  background(0);
  move();
  display();
}

void move() {
  x = x + xspeed;
  if (x > width || x < 0) {
    xspeed = -xspeed;
  }
  y = y + yspeed;
  if (y > height || y < 0) {
    yspeed = -yspeed;
  }
}

void display() {
  fill(c);
  text(s, x, y);
}
