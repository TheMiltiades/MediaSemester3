/**
 * Advanced Background Subtraction by Jorge Cardoso
 * Based on example by Golan Levin
 */

import JMyron.*;
public class BackgroundSubtraction {

  int width, height;

  int backgroundPixels[];
  int []subtraction;
  long presenceSum = 0;
  int alphaChannel[];
  PImage currentFrame;
  JMyron m;

  boolean invertAlphaChannel = true;

  // the length of segments in the silhouette
  int silhuetteSegmentLength = 10;
  int blurRadius = 2;
  int jMyronColorThreshold = 255;
  int subtractionThreshold = 100;

  public void setSilhouetteSegmentLength(int segLength) {
    silhuetteSegmentLength = segLength;
  }

  public void setBlurRadius(int radius) {
    blurRadius = radius;
  }
  public void setJMyronColorThreshold(int threshold) {
    jMyronColorThreshold = threshold;
  }
  public void setSubtractionThreshold(int threshold) {
    subtractionThreshold = threshold;
  }
  public BackgroundSubtraction(int width, int height) {
    this.width = width;
    this.height = height;
    backgroundPixels = new int[width*height];
    alphaChannel = new int[width*height];
    subtraction = new int[width*height];

    presenceSum = 0;
    m = new JMyron();
    m.start(width, height);
    m.trackColor(255, 255, 255, jMyronColorThreshold);
    m.minDensity(500);
  }

  public void update() {
    m.update();
    currentFrame = new PImage(this.width, this.height);
    arraycopy(m.image(), currentFrame.pixels);
  }

  public PImage currentFrame() {
    return currentFrame;
  }

  public void settings() {
    m.settings();
  }
  public void invertAlphaChannel(boolean invert) {
    invertAlphaChannel = invert;
  }

  public void setBackground() {
    setBackground(m.image());
  }

  public void setBackground(int []frame) {
    arraycopy(frame, backgroundPixels);
    presenceSum = 0;
  }

  public long getQuantityOfMovement() {
    return presenceSum;
  }
  public int[] getSubtraction() {
    return subtraction;
  }
  public PImage getSubtractionImage() {
    PImage img = new PImage(this.width, this.height);
    arraycopy(subtraction, img.pixels);
    return img;
  }
  
  public int[] getAlphaChannel() {
    return alphaChannel;
  }

  public void subtract() {
    subtract(m.image());
  }

  /*
   * Subtract with default values.
   */
  public void subtract(int []frame) {
    subtract(frame, subtractionThreshold, true, true, true, true, false);
  }

  /** 
   * General purpose method.
   */
  private void subtract(int []frame, int threshold, boolean binarize, boolean cRed, boolean cGreen, boolean cBlue, boolean onlyBackground) {
    for (int i = 0; i < frame.length; i++) { // For each pixel in the video frame...
      // Fetch the current color in that location, and also the color
      // of the background in that spot
      color currColor = frame[i];
      color bkgdColor = backgroundPixels[i];
      // Extract the red, green, and blue components of the current pixelÕs color
      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract the red, green, and blue components of the background pixelÕs color
      int bkgdR = (bkgdColor >> 16) & 0xFF;
      int bkgdG = (bkgdColor >> 8) & 0xFF;
      int bkgdB = bkgdColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - bkgdR);
      int diffG = abs(currG - bkgdG);
      int diffB = abs(currB - bkgdB);
      // Add these differences to the running tally
      int sub = ( (cRed?diffR:0) + (cGreen?diffG:0) + (cBlue?diffB:0));
      presenceSum += sub;
      // Render the difference image to the screen

      //subtraction[i] = color(diffR, diffG, diffB);
      // The following line does the same thing much faster, but is more technical
      int c = (0xFF000000 | ((cRed?diffR:0) << 16) | ((cGreen?diffG:0) << 8) | (cBlue?diffB:0));

      subtraction[i] =  sub < threshold ? 0 : (binarize ? 0xffffffff : (onlyBackground?frame[i]:c));
      if (invertAlphaChannel) {
        alphaChannel[i] = sub < threshold ? 0xffffff : 0;
      } 
      else {
        alphaChannel[i] = sub < threshold ? 0 : 0xffffff;
      }
    }

    //println(presenceSum); // Print out the total amount of movement
  }

  public float [][] getSilhouette() {
    PImage alpha = new PImage(this.width, this.height);
    arraycopy(alphaChannel, alpha.pixels);

    fastblur(alpha, blurRadius);

    m.hijack(this.width, this.height, alpha.pixels);
    m.update();

    int[][][] list = m.globEdgePoints(silhuetteSegmentLength);//get the outlines

    //find the biggest glob
    int big = 0;
    int biggest = -1;
    for(int i=0;i<list.length;i++){
      if (list[i] != null) {
        if (list[i].length > big) {
          big = list[i].length;
          biggest = i;
        }
      }
    }


    if (biggest != -1) {
      float [][] points = new float[big][2];

      for (int i = 0; i < list[biggest].length; i++) {
        points[i][0] = (float)list[biggest][i][0]/this.width;
        points[i][1] = (float)list[biggest][i][1]/this.height;

        // jmyron sometimes makes polygons with shooting vertexes... let's try to remove them
        // by making them the same value as the previous vertex.
        if (i> 1 && dist(points[i-1][0], points[i-1][1], points[i][0],points[i][1])  > 0.2) {
          points[i][0] = points[i-1][0];
          points[i][1] = points[i-1][1];
        }

      }
      return points;
    }  
    else {
      return null;
    }
  }
  

  // ==================================================
  // Super Fast Blur v1.1
  // by Mario Klingemann <http://incubator.quasimondo.com>
  // ==================================================
  void fastblur(PImage img,int radius){

    if (radius<1){
      return;
    }
    int w=img.width;
    int h=img.height;
    int wm=w-1;
    int hm=h-1;
    int wh=w*h;
    int div=radius+radius+1;
    int r[]=new int[wh];
    int g[]=new int[wh];
    int b[]=new int[wh];
    int rsum,gsum,bsum,x,y,i,p,p1,p2,yp,yi,yw;
    int vmin[] = new int[max(w,h)];
    int vmax[] = new int[max(w,h)];
    int[] pix=img.pixels;
    int dv[]=new int[256*div];
    for (i=0;i<256*div;i++){
      dv[i]=(i/div); 
    }

    yw=yi=0;

    for (y=0;y<h;y++){
      rsum=gsum=bsum=0;
      for(i=-radius;i<=radius;i++){
        p=pix[yi+min(wm,max(i,0))];
        rsum+=(p & 0xff0000)>>16;
        gsum+=(p & 0x00ff00)>>8;
        bsum+= p & 0x0000ff;
      }
      for (x=0;x<w;x++){

        r[yi]=dv[rsum];
        g[yi]=dv[gsum];
        b[yi]=dv[bsum];

        if(y==0){
          vmin[x]=min(x+radius+1,wm);
          vmax[x]=max(x-radius,0);
        } 
        p1=pix[yw+vmin[x]];
        p2=pix[yw+vmax[x]];

        rsum+=((p1 & 0xff0000)-(p2 & 0xff0000))>>16;
        gsum+=((p1 & 0x00ff00)-(p2 & 0x00ff00))>>8;
        bsum+= (p1 & 0x0000ff)-(p2 & 0x0000ff);
        yi++;
      }
      yw+=w;
    }

    for (x=0;x<w;x++){
      rsum=gsum=bsum=0;
      yp=-radius*w;
      for(i=-radius;i<=radius;i++){
        yi=max(0,yp)+x;
        rsum+=r[yi];
        gsum+=g[yi];
        bsum+=b[yi];
        yp+=w;
      }
      yi=x;
      for (y=0;y<h;y++){
        pix[yi]=0xff000000 | (dv[rsum]<<16) | (dv[gsum]<<8) | dv[bsum];
        if(x==0){
          vmin[y]=min(y+radius+1,hm)*w;
          vmax[y]=max(y-radius,0)*w;
        } 
        p1=x+vmin[y];
        p2=x+vmax[y];

        rsum+=r[p1]-r[p2];
        gsum+=g[p1]-g[p2];
        bsum+=b[p1]-b[p2];

        yi+=w;
      }
    }
  }

}
