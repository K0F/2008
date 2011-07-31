import processing.opengl.*;

import ddf.minim.analysis.*;
import ddf.minim.*;

AudioPlayer jingle;
FFT fft;
float tresh = 1.5;
float bands[] = new float [100];
float last[] = new float [bands.length];
float thetas[] = new float[bands.length];
void setup()
{
  size(512, 200,OPENGL);
  // always start Minim before you do anything with it
  Minim.start(this);
  jingle = Minim.loadFile("jingle.mp3");
  jingle.loop();
  // create an FFT object that has a time-domain 
  // buffer the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 512.
  fft = new FFT(jingle.left.size(), 22050);




  for(int i= 0;i<bands.length;i++){
    bands[i] = 5;
    last[i] = bands[i];
    thetas[i] = 0;

  }
}

void draw()
{
  background(0);
  stroke(255);
  // perform a forward FFT on the samples in jingle's left buffer
  // note that if jingle were a MONO file, 
  // this would be the same as using jingle.right or jingle.mix
  fft.forward(jingle.left);
  int what = 0;
  for(int i = 0; i < fft.specSize(); i++)
  {
    // draw the line for frequency band i, 
    // scaling it by 4 so we can see it a bit better
    stroke(255,80);
    //line(i, height, i, height - fft.getBand(i)*4);
    what = (int)map(i,0,fft.specSize(),0,bands.length);
    bands[what] += ((height - fft.getBand( i )*8)-bands[what])/(20.0);

  }

  for(int i = 0;i<bands.length;i++){
    stroke(255,0,0);
    line(map(i,0,bands.length,0,width),bands[i],map(i+1,0,bands.length,0,width),bands[i]); 
    if(last[i]>bands[i]+tresh){
      noStroke();
      fill(255,0,0,95);
      rect(map(i,0,bands.length,0,width),bands[i],width/bands.length,-height);
    }
    float q= abs(last[i]-bands[i]);
    thetas[i]+=(q/10.0)/100.0;
    q = map(q,0.0,3.0,25,95);
    stroke(255,q);
    noFill();
    pushMatrix();
    translate(width/2.0,height/2.0);
    rotateY(thetas[i]);
    rotateX(thetas[i]/2.0);
    box(norm(i,bands.length,1)*height);
    popMatrix();
    last[i] = bands[i];
  }

  fill(255);
  // keep us informed about the window being used

}

void keyReleased()
{
  if ( key == 'w' ) 
  {
    // a Hamming window can be used to shape 
    // the sample buffer that is passed to the FFT
    // this can reduce the amount of noise in the spectrum
    fft.window(FFT.HAMMING);

  }

  if ( key == 'e' ) 
  {
    fft.window(FFT.NONE);

  }
}

void stop()
{
  // always close Minim audio classes when you finish with them
  jingle.close();
  // always stop Minim before exiting
  Minim.stop();

  super.stop();
}
