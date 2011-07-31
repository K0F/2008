import JMyron.*;

import processing.opengl.*;
import ddf.minim.effects.*;
import processing.video.*;
import ddf.minim.*;
import ddf.minim.signals.*;

JMyron m;
//////// camera res ////////
int numX = 320;
int numY = 240;
float koef = 0.5;
//////////////////////////////
int[] img;


AudioOutput out;
KofSynth sam;
LowPassFS lpf;
//MovieMaker mm;

void setup()
{
  size(numX, 200,OPENGL);
  
  frameRate(25);
  noFill();
  
  //mm = new MovieMaker(this,width,height,"drawing.mov",25, MovieMaker.JPEG, MovieMaker.HIGH);
  
  reset();
  
  lpf = new LowPassFS(100, out.sampleRate());
   lpf.setFreq(1350);
  out.addEffect(lpf);
   out.addSignal(sam);
  stroke(#FFCC22,(int)map(koef,0.0,2.0,55,1));
}

void draw()
{
  background(0);
  
  // draw the waveforms
  for(int i = 0; i < out.left.size()-1; i++)
  {
    line(map(i,0,out.left.size(),0,width), 50 + out.left.get(i)*50, map(i,0,out.left.size(),0,width)+1, 50 + out.left.get(i+1)*50);
    line(map(i,0,out.left.size(),0,width), 150 + out.right.get(i)*50, map(i,0,out.left.size(),0,width)+1, 150 + out.right.get(i+1)*50);
  }
  
  //mm.addFrame();
}
/*
void keyPressed(){
  if(keyCode==ENTER){
    mm.finish();
    println("movie finished");
  }
  keyPressed=false;
  
}*/



void reset(){
      
 numX = (int)(koef*numX);
  numY = (int)(koef*numY);

  Minim.start(this);
  out = Minim.getLineOut(Minim.STEREO, numX*numY);
  sam = new KofSynth();
  

  img = new int[numX*numY];

  // adds the signal to the output

  m = new JMyron();//obj
  m.start(numX,numY);//45,36);//320x240
  m.findGlobs(0);      
  
}

void stop()
{
  out.close();
  super.stop();
}
