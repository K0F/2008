int cnnt = 0;

int TX=0,TY=0;
color colo[] = new color[0];

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
  size(320,240,P3D);
  //frameRate(30);
  //frame.setAlwaysOnTop(true);
  noCursor();  
  textFont(loadFont("AlMohanad-10.vlw"));
  //textMode(SCREEN);
  rectMode(CENTER);

  snif = new Sniffer(3);
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
  if(viz.length>0)
  if(snif.data.length>(width/(5.0))*(height/(5.0))){
    snif.clean(1);
    shift = snif.data.length*10;
  }

  if(ysh2>5){
    if(snif.data[snif.data.length-1]!=null)
      if((int)snif.dataB[snif.dataB.length-1]>high)high = (int)snif.dataB[snif.dataB.length-1];
    if((int)snif.dataB[snif.dataB.length-1]<low)low = (int)snif.dataB[snif.dataB.length-1]; 
    //playnote((int)snif.dataB[snif.dataB.length-1]);
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
  

  if(visual){	
    textAlign(CENTER);
    if(viz.length>0)
      for(int i =0;i<viz.length;i++){
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



