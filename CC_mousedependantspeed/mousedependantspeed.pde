color c = color(0);
float x = 0;
float y = 100;
float xspeed = 150;
float yspeed = 10;

void setup() {
  size(1080,1350);
}

void draw() {
  xspeed = mouseX / 3;
  yspeed = mouseY / 3;
  background(255);
  move();
  display();
}

void move() {
  x = x + xspeed;
  if (x > width) {
    x = 0;
  }
  y = y + yspeed;
  if (y > height) {
    y = 0;
  }
}

void display() {
  fill(c);
  rect(x, y, 300, 100);
}
