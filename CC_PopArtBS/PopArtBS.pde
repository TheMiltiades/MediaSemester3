/**
 * PopArtBS
 * Advanced background subtraction - Masking and silhouette demo.
 *
 * by Jorge Cardoso
 * 05-Jan-2k8
 * 
 */
import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import traer.physics.*;
import processing.opengl.*;
import processing.video.*;



BackgroundSubtraction bs = new BackgroundSubtraction(320, 240);
int silhuetteSegmentLength = 10;
int bgSubtractionThreshold = 35;

int centerX, centerY; // the center of the silhouette.

PImage fundo;

ParticleSystem pSystem;
Particle p[]; // the particle
Attraction a[];
Particle attractorParticle;
int numParticles = 200;

boolean drawObject = false;
boolean invert = false;
boolean drawParticles = true;
boolean particlesInside = true;
boolean showOriginal = false;
boolean saving = false;

MovieMaker mm;  // Declare MovieMaker object

void setup() {
  // Change size to 320 x 240 if too slow at 640 x 480
  size(800, 600, P3D); 


  fundo = loadImage("popart.jpg");
  PFont f = loadFont("ArialMT-48.vlw");
  textFont(f);
  frameRate(10);

  pSystem = new ParticleSystem(0, 0);
  attractorParticle = pSystem.makeParticle(1, 0, 0, 0);
  attractorParticle.makeFixed();
  p = new Particle[numParticles];
  a = new Attraction[numParticles];
  for (int i = 0; i < numParticles; i++) {
    p[i] = pSystem.makeParticle(1, random(width), random(height), 0);

  }
  for (int i = 0; i < numParticles; i++) {

    for (int j = 0; j < numParticles; j++) {
      pSystem.makeAttraction(p[i],  p[j], -250, 10);
    }

  }
  frameRate(20);

}

void draw() {
  background(0);

  bs.update();  

  bs.invertAlphaChannel(invert);

  bs.subtract();

  if (!drawParticles) {
    strokeWeight(5);
    for (int i = 0; i <= 1.5*height; i += 10) {
      stroke(sin(radians(frameCount*0.1*i))*127+127, sin(radians(frameCount*i*0.2))*127+127, sin(radians(frameCount*0.6))*127+127);
      line(0, i, i, 0);
    }

    for (int i = 0; i < 1.5* height; i += 10) {
      stroke(sin(radians(frameCount*0.1*i))*127+127, sin(radians(frameCount*i*.2))*127+127, sin(radians(frameCount*0.6))*127+127);
      line(width, height-i, width-i, height);
    }
  }
  if (invert) {
    PImage img = new PImage (fundo.width, fundo.height);
    arraycopy(fundo.pixels, img.pixels);

    PImage alpha = new PImage(320, 240);
    arraycopy(bs.getAlphaChannel(), alpha.pixels);
    //image(alpha, 0, 0);
    img.mask(scale(alpha, fundo.width, fundo.height));
    image(img, 0, 0);
  } 
  else {
    drawSilhouette();
  }
  if (showOriginal) {
    image(bs.currentFrame(), 0, 0);
    image(bs.getSubtractionImage(), 320, 0);
  }
  if (saving) {
    mm.addFrame();  // Add window's pixels to movie
  }
  //println(frameRate);
}

PImage scale(PImage img, int width, int height) {

  PGraphics g = createGraphics(width, height, JAVA2D);
  g.beginDraw();
  g.image(img,0, 0, width, height);
  g.endDraw();
  return g;
}

void drawSilhouette() {
  stroke(255);
  float [][] s=   bs.getSilhouette();
  if (s != null) {
    centerX = 0;
    centerY = 0;
    beginShape(POLYGON);
    if (!drawParticles) {
      texture(drawObject?bs.currentFrame():fundo);
    } 
    else {
      noFill();
      stroke(100);

    }
    for (int i = 0; i < s.length; i++) {
      //line(s[i][0]*320, s[i][1]*240, s[i*2+1][0]*320, s[i*2+1][1]*240);
      centerX+=s[i][0]*width;
      centerY+=s[i][1]*height;
      
      if (!drawParticles) {
        if (drawObject) {
          vertex(s[i][0]*width, s[i][1]*height,s[i][0]*320, s[i][1]*240 );
        } 
        else {
          vertex(s[i][0]*width, s[i][1]*height,s[i][0]*fundo.width, s[i][1]*fundo.height );
        }
      } 
      else {
        vertex(s[i][0]*width, s[i][1]*height);
      }
    }
    if (!drawParticles) {
      if (drawObject) {
        vertex(s[0][0]*width, s[0][1]*height,s[0][0]*320, s[0][1]*240 );
      } 
      else {
        vertex(s[0][0]*width, s[0][1]*height,s[0][0]*fundo.width, s[0][1]*fundo.height );
      }
    } 
    else {
      vertex(s[0][0]*width, s[0][1]*height);
    }
    endShape();
    centerX/=s.length;
    centerY/=s.length;
    if (drawParticles) {
      // transform the coord to the appropriate format for unlekker
      float poly[] = new float[2*s.length+2];
      for (int i = 0; i < s.length; i++) {
        poly[2*i] = s[i][0]*width;
        poly[2*i+1] = s[i][1]*height;
      }
      poly[poly.length-2] = poly[0];
      poly[poly.length-1] = poly[1];
      //println(Intersect.insidePolygon(centerX, centerY, poly));
      stroke(0);
      fill(0);
      colorMode(HSB);
      for (int i = 0; i < numParticles; i++) {
        if (particlesInside && !Intersect.insidePolygon(p[i].position().x(), p[i].position().y(), poly)) {
          //println("insidepoly");
          float x, y;
          x = random(width);
          y = random(height);
          if(Intersect.insidePolygon(x, y, poly)) {
            p[i].moveTo(x, y, 0);

          } 
          else {
            p[i].setVelocity(0.01*(centerX-p[i].position().x()), 0.01*(centerY-p[i].position().y()), 0);
          }
          //p[i].setVelocity(0.05*(centerX-p[i].position().x()), 0.01*(centerY-p[i].position().y()), 0);
          //p[i].moveTo(centerX+random(10), centerY+random(10), 0);
        } 
        else if(!particlesInside && Intersect.insidePolygon(p[i].position().x(), p[i].position().y(), poly)) {
          float x, y;
          x = random(width);
          y = random(height);
          if(!Intersect.insidePolygon(x, y, poly)) {
            p[i].moveTo(x, y, 0);

          } 
          else {
            p[i].setVelocity(-0.01*(centerX-p[i].position().x()), -0.01*(centerY-p[i].position().y()), 0);

          }

        }
        p[i].moveTo(constrain(p[i].position().x(), 0, width), constrain(p[i].position().y(), 0, height), 0);
        //fill((255/numParticles)*i, (255/numParticles)*i, 255, 200);
        fill((255/numParticles)*i, 255, 255);
        ellipse(p[i].position().x(), p[i].position().y(), 10, 10);
      }
      colorMode(RGB);
    }
    // fill(255);
    // ellipse(centerX, centerY, 20, 20);
  }
  pSystem.tick();
}

void keyPressed() {
  if (key == 'm') {
    if (saving) {
      mm.finish();  // Finish the movie if space bar is pressed!
      println("Finished saving video");
    } 
    else {
      mm = new MovieMaker(this, width, height, "drawing"+frameCount+".mov",  10, MovieMaker.VIDEO, MovieMaker.HIGH);
      println("Started saving video");
    } 
    saving = !saving;
  } 
  else
    if (key == ' ') {
      bs.update();
      bs.setBackground();
      println("setting bg");
    } 
    else if (key == 'o') {
      drawObject = !drawObject;
    }
    else if (key == 'i') {
      invert = !invert;
    } 
    else if (key == 'p') {
      drawParticles = !drawParticles;
    }
    else if (key == 'r') {
      particlesInside = !particlesInside;
    }
    else if (key == '+' ) {
      bgSubtractionThreshold = bgSubtractionThreshold + 5;
      bs.setSubtractionThreshold(bgSubtractionThreshold);
      println("Subtraction Threshold: " + bgSubtractionThreshold);
    }
    else if (key == '-' ) {
      bgSubtractionThreshold = bgSubtractionThreshold - 5;
      bs.setSubtractionThreshold(bgSubtractionThreshold);
      println("Subtraction Threshold: " + bgSubtractionThreshold);
    } 
    else if(key =='s') {
      bs.settings();
    }  
    else if(key =='d') {
      showOriginal = !showOriginal;
    }

}
