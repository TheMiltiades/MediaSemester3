import gab.opencv.*;

import processing.video.*;
import java.awt.Rectangle;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480, P2D);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);

  opencv.startBackgroundSubtraction(50, 2, 0.5);

  video.start();
}

void draw() {  
  opencv.loadImage(video);
  opencv.updateBackground();
  
  opencv.dilate();
  opencv.erode();

  image(video, 0, 0);
  
  fill(222);
  for(Contour contour : opencv.findContours()){
    Rectangle r = contour.getBoundingBox();
    rect(r.x, r.y, r.width, r.height);
  }    
}

void movieEvent(Movie m) {
  m.read();
}
