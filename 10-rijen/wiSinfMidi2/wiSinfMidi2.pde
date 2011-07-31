import promidi.*;
color colo[] = new color[0];

MidiIO midiIO;
MidiOut midiOut;
Note note;

boolean playing = false;

boolean visual = true;
boolean debug = true;
boolean showPackets = true;

int dur = 0;
int tresh = 10;

Sniffer snif;
Viz viz[] = new Viz[0];

void setup(){
  size(screen.width/2,screen.height/2,P3D);
  //frameRate(30);
  frame.setAlwaysOnTop(true);
  noCursor();  
  textFont(loadFont("AlMohanad-10.vlw"));
  textMode(SCREEN);
  rectMode(CENTER);
  
  midiIO = MidiIO.getInstance(this);
  midiIO.printDevices();
    midiOut = midiIO.getMidiOut(0,0);

  snif = new Sniffer();
  snif.start();
}

float ysh =0,ysh2,shift;
//boolean arp = false;
void draw(){
  
  background(0);
  fill(255);
  
  if(playing){
   dur++; 
  }
    
  if(dur>tresh){
    tresh=(int)random(1,20);
   dur=0;
  playing=false; 
  }
  
  shift +=((snif.data.length*10.0)-shift)/10.0;
  ysh += ((snif.counter*10.0)-ysh)/10.0;
  ysh2 = abs(ysh-snif.counter*10.0)*20.0;
  if(ysh2<10&&snif.data.length>100){
    snif.clean(snif.data.length-100);
    shift = snif.data.length*10;
  }
  
  if(ysh2>50){
    if(snif.data[snif.data.length-1]!=null)
    playnote((int)snif.dataB[snif.dataB.length-1]);
  }
  
  //pushMatrix();
    if(debug){
  for(int i = 0; i < snif.data.length;i++){
	//println(snif.data[i].charAt(8));
    if(snif.data[i].length()>8&&snif.data[i].charAt(8)=='['){
      //arp=true;
     fill(255,25,11); 
    }else if(snif.data[i].substring(0,3).equals("ARP")){
      //arp=false;
     fill(255,155,0); 
    }else{
     fill(255,55); 
    }
  text(snif.data[i],10,i*10-shift+height);
  }
}

if(visual){	
textAlign(CENTER);
if(viz.length>0)
for(int i =1;i<viz.length;i++){
	if(viz[i]!=null)	
	viz[i].draw();
}
}
  textAlign(LEFT);
  //popMatrix();
  
}

void keyPressed(){
	if(key=='q'){
		exit();
	}

}


 void playnote(int in){
   if(!playing){
   int ii = constrain((int)map(in,2000,10000,30,127),1,127);
   //println(in);
    note = new Note(ii,127,50);
    playing = true;
    midiOut.sendNote(note);
    
   }
  }




