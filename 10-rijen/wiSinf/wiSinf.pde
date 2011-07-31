//import ddf.minim.signals.*;
//import ddf.minim.*;
//import ddf.minim.analysis.*;
//import ddf.minim.effects.*;

color colo[] = new color[0];

boolean visual = false;
boolean debug = true;
boolean showPackets = true;

Sniffer snif;
Viz viz[] = new Viz[0];
//Minim minim;
//BandPass bpf;
//just
//AudioOutput out;
//SineWave sine;
//PinkNoise pn;
//WhiteNoise wn;

void setup(){
  size(screen.width/2,screen.height/2,P3D);
  //frameRate(30);
  //frame.setAlwaysOnTop(true);
  noCursor();  
  textFont(loadFont("AlMohanad-10.vlw"));
  textMode(SCREEN);
  rectMode(CENTER);
  
  //minim = new Minim(this);
  //out = minim.getLineOut(Minim.STEREO);
  
 // sine = new SineWave(440, 0.5, out.sampleRate());
  //sine.portamento(200);
  //pn = new PinkNoise(0.0);
  //wn = new WhiteNoise(0.0);
  //bpf = new BandPass(440, 20, out.sampleRate());
  //out.addSignal(sine);
  //out.addSignal(pn);
  //out.addSignal(wn);
  //out.addEffect(bpf);

  snif = new Sniffer();
  snif.start();
}

float ysh =0,ysh2,shift;
//boolean arp = false;
void draw(){
  
  background(0);
  fill(255);
  
  shift +=((snif.data.length*10.0)-shift)/10.0;
  ysh += ((snif.counter*10.0)-ysh)/10.0;
  ysh2 = abs(ysh-snif.counter*10.0)*20.0;
  if(ysh2<10&&snif.data.length>100){
    snif.clean(snif.data.length-100);
    shift = snif.data.length*10;
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



