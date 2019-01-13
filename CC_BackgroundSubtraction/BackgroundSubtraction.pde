import processing.video.*;

int diffThreshold = 150;

int numPixels;
int[] backgroundPixels;
Capture video;

void setup() {
  frameRate(30);
  size(640, 480); 
  video = new Capture(this, width, height);
  
  video.start();  
  
  numPixels = video.width * video.height;
  backgroundPixels = new int[numPixels];
  loadPixels();
}

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    
    int presenceSum = 0;
    for (int i = 0; i < numPixels; i++) {
      color currColor = video.pixels[i];
      color bkgdColor = backgroundPixels[i];
      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      
      int bkgdR = (bkgdColor >> 16) & 0xFF;
      int bkgdG = (bkgdColor >> 8) & 0xFF;
      int bkgdB = bkgdColor & 0xFF;
      
      int diffR = abs(bkgdR - currR);
      int diffG = abs(bkgdG - currG);
      int diffB = abs(bkgdB - currB);
      
      presenceSum = diffR + diffG + diffB;
      
      if(presenceSum < diffThreshold){
        pixels[i] = color(222);
      }else{
        pixels[i] = color(100);
      }
    }
    updatePixels();
    println(presenceSum);
    video.loadPixels();
  }
}
void keyPressed() {
  video.loadPixels();
  arraycopy(video.pixels, backgroundPixels);
}
