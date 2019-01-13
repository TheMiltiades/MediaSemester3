color c = color(255);
float x = 0;
float y = 100;
float xspeed = 0;
float yspeed = 0;
String s = "HOI";
float tw;

void setup(){
  size(1080, 675);
  frameRate(30);
  textSize(128);
  tw = textWidth(s);
  background(0);
}

void draw(){
  for(int ix = 0; ix < width / tw; ix = ix + 1){
    x = ix * tw;
      for(int iy = 0; iy < height; iy = iy + 1){
        y = iy * 100;  
        text(s, x, y);
      }
  }
}
