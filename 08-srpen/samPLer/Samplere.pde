import ddf.minim.*;

class Samplere{
  AudioInput in;
  AudioRecorder recorder;
  AudioPlayer player;
  PApplet parent;
  boolean recording = false;
  int id;

  Samplere(PApplet _parent,int _id){
    parent = _parent;
    id=_id;
    Minim.start(parent);
    in = Minim.getLineIn(Minim.STEREO, 512);
    
  }

  void run(){
    if(recording){
      noStroke();
      fill(255,0,0,150);
     rect(10,10,5,5); 
    }

  }

  void record(){ 
    if(!recording){
      //in = Minim.getLineIn(Minim.STEREO, 512);
      recorder = Minim.createRecorder(in, "rec"+id+".wav", true);
      recorder.beginRecord();
      recording=true;  
    } 
    else{
      recorder.endRecord();
      recording = false; 
      AudioRecording recording = recorder.save();
      recording.open();
      recording.loop();
    }
  }


}
