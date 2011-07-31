import processing.opengl.*;
import ddf.minim.effects.*;
import processing.video.*;
import ddf.minim.*;
import ddf.minim.signals.*;


Movie mov;
//////// camera res ////////
int numX = 320;
int numY = 240;
float koef = 0.4;
//////////////////////////////
int[] img;
float dur;

AudioRecorder recorder;
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
  mov=new Movie(this, "dokumatMini.mov");
  mov.loop();
  dur = mov.duration();
  println("movie loaded!");
  println("dur.:"+dur);
  noSmooth();
  
  reset();
  
  lpf = new LowPassFS(100, out.sampleRate());
   lpf.setFreq(1350);
  out.addEffect(lpf);
   out.addSignal(sam);
  stroke(#FFCC22,(int)map(koef,0.0,1.0,55,1));
  
  recorder = Minim.createRecorder(out, "output.wav", true);
   recorder.beginRecord();
}

void draw()
{
  background(0);
  image(mov,0,0,mov.width/5.0,mov.height/5.0);
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

void keyReleased()
{
  if ( key == 'r' ) 
  {
    // to indicate that you want to start or stop capturing audio data, you must call
    // beginRecord() and endRecord() on the AudioRecorder object. You can start and stop
    // as many times as you like, the audio data will be appended to the end of the buffer 
    // (in the case of buffered recording) or to the end of the file (in the case of streamed recording). 
    if ( recorder.isRecording() ) 
    {
      recorder.endRecord();
    }
    else 
    {
      recorder.beginRecord();
    }
  }
  if ( key == 's' )
  {
    // we've filled the file out buffer, 
    // now write it to the file we specified in createRecorder
    // in the case of buffered recording, if the buffer is large, 
    // this will appear to freeze the sketch for sometime
    // in the case of streamed recording, 
    // it will not freeze as the data is already in the file and all that is being done
    // is closing the file.
    // the method returns the recorded audio as an AudioRecording, 
    // see the example  AudioRecorder >> RecordAndPlayback for more about that
    recorder.save();
    println("Done saving.");
  }
}

void movieEvent(Movie m) {
  if(m.available()){
    m.read();
  }
}


void reset(){
      
 numX = (int)(koef*numX);
  numY = (int)(koef*numY);

  Minim.start(this);
  out = Minim.getLineOut(Minim.STEREO, numX*numY);
  sam = new KofSynth();
  

  img = new int[numX*numY];

  // adds the signal to the output

    
  
}

void stop()
{
  out.close();
  super.stop();
}
