import promidi.*;
MidiIO midiIO;
MidiOut midiOut;

int num = 10;
float[] vals = new float[num];
float[] tvals = new float[num];
Controller[] c = new Controller[num];

float speed = 100.0;

void setup(){
  size(127*2,100,P3D);
  frameRate(25);
  midiIO = MidiIO.getInstance(this);
  midiOut = midiIO.getMidiOut(0,0);
  
  for(int i = 0;i<vals.length;i++){
    vals[i] = 0.0;
    tvals[i] = random(0,127);
    c[i] = new Controller(i,0);//.setValue((int)vals[i]);
  }
  
  fill(255,100);
  stroke(255);
}

void draw(){
  background(0);

  for(int i = 0;i<vals.length;i++){
    rect(0,i*5,vals[i]*2,5);
    //line (tvals[i]*2,i*5,tvals[i]*2,i*5+5);
    vals[i] += (tvals[i]-vals[i]) / speed;
    if(abs(tvals[i]-vals[i])<1){
     tvals[i] = random(0,127);
    }
    c[i].setValue((int)vals[i]);
    midiOut.sendController(c[i]);
  }
}


