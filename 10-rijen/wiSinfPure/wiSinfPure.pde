import promidi.*;

color colo[] = new color[0];

MidiIO midiIO;
MidiOut midiOut;
Note note;

int high = 0,low = 1000000;

int not = 10;
int coll = 60;

int[][] noteCollector = new int[not][coll];
int noteCounter[] = new int[not];

boolean playing = false;

boolean visual = true;
boolean debug = false;
boolean showPackets = true;
boolean tune = true;

Sniffer snif;
Viz viz[] = new Viz[0];

void setup(){
  size(screen.width/2,screen.height/2,P3D);
  //frameRate(30);
  //frame.setAlwaysOnTop(true);
  noCursor();  
  textFont(loadFont("AlMohanad-10.vlw"));
  textMode(SCREEN);
  rectMode(CENTER);

  //midiIO = MidiIO.getInstance(this);
  //midiIO.printDevices();
  //midiOut = midiIO.getMidiOut(0,0);

  snif = new Sniffer(1);
  snif.start();

  for(int i =0 ;i<noteCounter.length;i++)
    noteCounter[i] = 0;
}

float ysh =0,ysh2,shift;
//boolean arp = false;
void draw(){

  background(0);
  fill(255);


  shift +=((snif.data.length*10.0)-shift)/10.0;
  ysh += ((snif.counter*10.0)-ysh)/10.0;
  ysh2 = abs(ysh-snif.counter*10.0)*20.0;
  if(snif.data.length>60){
    snif.clean(snif.data.length-60);
    shift = snif.data.length*10;
  }

  if(ysh2>5){
    if(snif.data[snif.data.length-1]!=null)
      if((int)snif.dataB[snif.dataB.length-1]>high)high = (int)snif.dataB[snif.dataB.length-1];
    if((int)snif.dataB[snif.dataB.length-1]<low)low = (int)snif.dataB[snif.dataB.length-1]; 
    playnote((int)snif.dataB[snif.dataB.length-1]);
  }

  //pushMatrix();
  if(debug){
    
    for(int i = 0; i < snif.data.length;i++){
     /*
      //println(snif.data[i].charAt(8));
      if(snif.data[i].length()>8&&snif.data[i].charAt(8)=='['){
        //arp=true;
        fill(255,25,11); 
      }
      else if(snif.data[i].substring(0,3).equals("ARP")){
        //arp=false;
        fill(255,155,0); 
      }*/
      //else{
        fill(255,55); 
      //}
      if(snif.data[i]!=null)
      text(snif.data[i],10,i*10-shift+height);
    }
  }
    if(tune){
      for(int o = 0;o<noteCollector.length;o++){
	int kolik = 0;;
        for(int p = 0;p<noteCollector[o].length;p++){
          if(noteCollector[o][p]>0){
	kolik++;
           fill(255,20); 
           if(o==0){
            stroke(255,map(noteCollector[o][p],0,max(noteCollector[o]),0,255));
             
           }else{
            stroke(255,map(noteCollector[o][p],max(noteCollector[o-1]),max(noteCollector[o]),0,255));
           }
            //fill(255,95);
            rect(p*10+20,o*10+10,8,8);
          }
		controll(o,(int)map(kolik,0,coll,0,127));

        }
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
    int ii = constrain((int)map(in,low,high,52,127),52,127);
    int ident = (int)map(ii,52,127,0,noteCollector.length-1);

    noteCollector[ident][noteCounter[ident]] = ii;
    noteCounter[ident]++;

    if(noteCounter[ident]>=noteCollector[ident].length){
      noteCounter[ident] = 0;


      float resume = 0;
      for(int i = 0;i<noteCollector[ident].length;i++){
        resume+=noteCollector[ident][i];
        noteCollector[ident][i] = 0;
      }
      resume /= (noteCollector[ident].length+0.0);
      sendM(resume);
      //      println(resume);
    }
    //print();

    /*
    note = new Note(ii,127,50);
     playing = true;
     midiOut.sendNote(note);
     */
  }
}

void sendM(float in){
 // int mod = (int)map(in,0,127,0,20);
  note = new Note((int)in,(int)random(50,127),7000);
  //playing = true;
  midiOut.sendNote(note);

}



void controll(int n,int v){
	midiOut.sendController(new Controller(n,v));
}


