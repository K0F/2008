import JMyron.*;

import processing.opengl.*;

/**
  * This sketch demonstrates how to implement your own AudioSignal for Minim. See KofSynth.pde for the implementation.
  */

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.effects.*;
float[] data = new float[512];
 JMyron m;
  int numX = 32;//45;
  int numY = 24;//36;
  int[] img;


AudioOutput out;
KofSynth sam;
LowPassFS lpf;
void setup()
{
  size(numX*numY, 200,OPENGL);
  
  Minim.start(this);
  out = Minim.getLineOut(Minim.STEREO, numX*numY);
  sam = new KofSynth();
    lpf = new LowPassFS(100, out.sampleRate());
   lpf.setFreq(1800);
   out.addEffect(lpf);
   img = new int[numX*numY];
  
  // adds the signal to the output
  for(int i = 0;i<data.length;i++){
   data[i] = random(-1.0,1.0); 
    
  }
  
  m = new JMyron();//obj
    m.start(numX,numY);//45,36);//320x240
    m.findGlobs(0);     
 
 
  out.addSignal(sam);
  
 
  
}

void draw()
{
  background(0);
  stroke(255);
  
  // draw the waveforms
  for(int i = 0; i < out.left.size()-1; i++)
  {
    line(i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50);
    line(i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50);
  }
}

void stop()
{
  out.close();
  super.stop();
}
