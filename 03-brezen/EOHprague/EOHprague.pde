// Earth_On_heaven :: inclusiva version

import java.io.File;
import processing.opengl.*;

/////////////////////////////////////////////////////////////////////////////////////
//// main visualisation>> for stars TRUE, for debug FALSE //////////////////// >
boolean VIZ = false;
//// address and port for osc sending  //////////////////// >
String address = "127.0.0.1"; //
int port = 11999;
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

Person persons[] = new Person[0];
boolean ready,sending = false;
OSC osc;
//FullScreen fs;

int cnt = 0;
float zoom = 0;
float Z = 1;
float xshift,yshift;
float globLon[],globLat[];
// centers of persons
float centersLat[],centersLon[];
//centre of the map
float globCenterLat,globCenterLon;
int k=1;
int allPoints = 0;
//// aspect ratio //////////////////// >
float aspect;

float globSpeed = 30;

void setup() {
  //size(screen.width,screen.height,OPENGL); //P3D or OPENGL
  size(1024,768,OPENGL);
  frame.setTitle("Earth_On_Heaven_pre6");
  frame.setLocation(0,0);
  frameRate(25);
  //frame.setAlwaysOnTop(true);
  if(!VIZ){
    cursor(CROSS);
  }
  else{
    noCursor();
  }
  //smooth();

  String path = sketchPath("data/icon.gif");
  path.replace('\\','/');
  Image img = getToolkit().getImage(path);
  frame.setIconImage(img);

  osc = new OSC(address,port);
  noStroke();
  //// loading data from ./persons/ directory gpx and files needed //////////////////// >
  //// casting persons for each .gpx and .txt file founded //////////////////// >
  loadDataFromFiles2();
  //// computing the scale stuff from points loaded //////////////////// >
  allPoints = getNumberOfAllPointsLoaded();
  globLon = new float[allPoints];
  globLat = new float[allPoints];
  centersLat = new float[persons.length];
  centersLon = new float[persons.length];
  //// scaling procedures //////////////////// >
  scaleThat();
  //// aspect ration setting //////////////////// >
  aspect = (abs(min(globLon)-max(globLon))/abs(min(globLat)-max(globLat)));
  println("aspect ratio: "+aspect);

  //// debug console prints //////////////////// >
  println("no. of persons: "+cnt);
  println("glob Lons: "+min(globLon)+" "+max(globLon));
  println("glob Lats: "+min(globLat)+" "+max(globLat));
  for(int i =0;i<allPoints;i++){
    if(globLat[i]==0.0){
      println("noise on Lat:"+i);
    }
    if(globLon[i]==0.0){
      println("noise on Lon:"+i);
    }
  }
  ///////////////////////////////////////
  //note:
  //the .gpx files must be in processing "/persons" folder
  //the text files must have the same name and to be placed in the same directory
  background(0);
}

//// init called before PApplet loads //////////////////// >
void init(){
  frame.setUndecorated(true);
  super.init();
}

//// main draw loop //////////////////// >
void draw() {
  background(0);

  pushMatrix();
 // translate(-Z*width,-Z*height);
  scale(Z,Z);
  translate(xshift,yshift);
  drawPersons();
  popMatrix();

  if(!VIZ){
    drawLegend();
  }
}

//// run all person classes //////////////////// >
void drawPersons(){
  for (int i = 0; i < persons.length; i++) {
    persons[i].draw();
    if(sending){
      osc.send(persons[i].id,persons[i].movingStar.lon,persons[i].movingStar.lat);
    }
  }
}

//// zoom scale recomputing- bugs //////////////////// >
void zoom(){
  zoom = map(mouseY,0,height,0,4000);

  for (int i = 0; i < persons.length; i++) {
    for (int q = 0; q < persons[i].fixedStars.length; q++) {
      persons[i].fixedStars[q].compute();
    }
    persons[i].movingStar.scaleXYs();
  }
  drawLegend();
}

//// upper right corner names //////////////////// >
void drawLegend(){
  for(int i = 0;i<persons.length;i++){
    fill(persons[i].c,155);
    text(persons[i].Lon.length+".::"+persons[i].name+" "+i,width-100,i*10+12);

  }


  if(sending){
    fill(255,128*(sin(frameCount/3.0)+1));
    text("broadcasting :: "+address+" @ "+(port+1),10,10);
  }
  fill(255);
  text("speed :: "+round(100.0-globSpeed),10,20);

}

//// user events //////////////////// >
void mousePressed(){
  if(mouseButton==LEFT){
    zoom();
  }
  else if(mouseButton==RIGHT){
    saveFrame("screens/screen-####.png");
  }
  mousePressed=false;

}

void keyPressed(){
  if(keyCode==LEFT){
    xshift+=10;
  }
  else if(keyCode==RIGHT){
    xshift-=10;
  }
  else if(keyCode==UP){
    yshift+=10;
  }
  else if(keyCode==DOWN){
    yshift-=10;
  }
  else if(key=='='){
    Z+=0.01;
  }
  else if(key=='-'){
    Z-=0.01;
  }else if(key=='0'){
    Z=1.0; 
  }
  else if(keyCode==ENTER){
    persons=new Person[0];
    loadDataFromFiles2();
    keyPressed=false;
  }  
  else if(keyCode==BACKSPACE){
    println(""+xshift);

  }
  else if(keyCode==123){
    VIZ=!VIZ;
    if(VIZ){
      noCursor();
    }
    else{
      cursor(CROSS);
    }
  }
  else if(keyCode==122){
    sending=!sending;

  }
  else if(key=='q'){
    globSpeed-=1;
    globSpeed=constrain(globSpeed,1.1,100);
  }
  else if(key=='a'){
    globSpeed+=1;
    globSpeed=constrain(globSpeed,1.1,100);
  }
  {
    println(keyCode);
  }
}


//// new one //////////////////// >
void loadDataFromFiles2(){
  String path = sketchPath+"/persons/";
  File dir = new File(path);
  File[] files = dir.listFiles();
  //println(dir.listFiles());

  for( int i=0; i < files.length; i++ ){
    String fileName = files[i].getName();

    if(fileName.endsWith("gpx")){
      String gpxName = files[i].getName();
      String txtName = gpxName.replace("gpx", "txt");

      String [] tmp = (splitTokens(gpxName,"."));
      String parsedName = tmp[0]+"";
      GPSTrack trk = new GPSTrack(this,gpxName,parsedName);
      String[] textFileStrings=loadStrings(path+txtName);
      String nam = parsedName+"";
      Person newPerson = new Person (textFileStrings, trk,nam,cnt);

      persons = (Person[])expand(persons,persons.length+1);
      persons[persons.length-1] = newPerson;
      println(parsedName+" loaded");
      cnt++;

    }// end txt if
  }// end loop
}// end void


