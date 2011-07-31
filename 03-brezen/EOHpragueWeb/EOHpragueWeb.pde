import oscP5.*;
import netP5.*;

import processing.xml.*;



/////////////////////////////////////////////////////////////////////////////////////
//// main visualisation>> for stars TRUE, for debug FALSE //////////////////// >
boolean VIZ = false;
//// address and port for osc sending  //////////////////// >
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

Mirror mirror;
Person persons[] = new Person[0];
boolean ready,sending = false;
//OSC osc;
//FullScreen fs;

int cnt2 = 0;
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
  size(500,400);
 // smooth();
  frameRate(30);
  cursor(CROSS);
  noStroke();
  smooth();
  textFont(createFont("Tahoma",9));
  
  mirror = new Mirror(this,"http://weirdplace.wz.cz/gpx/","askdir.php","data");

  loadDataFromFiles3();
  
  if(persons.length>0){
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
    println("no. of tracks loaded: "+cnt2);
    println("glob Lons: "+min(globLon)+" "+max(globLon));
    println("glob Lats: "+min(globLat)+" "+max(globLat));
    for(int i =0;i<allPoints;i++){
      if(globLat[i]==0.0f){
        println("noise on Lat:"+i);
      }
      if(globLon[i]==0.0f){
        println("noise on Lon:"+i);
      }
    }
  }
  else{
    println("no person created"); 
  }
  ///////////////////////////////////////
  //note:
  //the .gpx files must be in processing "/persons" folder
  //the text files must have the same name and to be placed in the same directory
  background(0);
}

//// init called before PApplet loads //////////////////// >


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
  fill(255);
  text("speed :: "+round(100.0f-globSpeed),10,20);
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
    Z+=0.01f;
  }
  else if(key=='-'){
    Z-=0.01f;
  }
  else if(key=='0'){
    Z=1.0f; 
  }
  else if(keyCode==ENTER){
    persons=new Person[0];
    loadDataFromFiles3();
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
    globSpeed=constrain(globSpeed,1.1f,100);
  }
  else if(key=='a'){
    globSpeed+=1;
    globSpeed=constrain(globSpeed,1.1f,100);
  }
}

public void loadDataFromFiles3(){
  String path = mirror.pathToScript+mirror.root+"/";//+"/persons/";
  String[] files;
  int[] which = new int[0];

  int cnt = 0;
  for(int i = 0;i<mirror.p.List.length;i++){
    if(mirror.isItFile(mirror.p.List[i])){
      which = (int[]) expand(which,which.length+1);
      which[cnt] = i;
      cnt++;
    }
  }

  files = new String[cnt];

  for(int i = 0;i<which.length;i++){    
    files[i] = mirror.cleanFilename(mirror.p.List[which[i]]+"");    
  }

  println(" ------ > ");
  println(files);

  for( int i=0; i < files.length; i++ ){
    String fileName = files[i]+"";

    if(mirror.getFileExtension(fileName).equals("gpx")){
      String gpxName = files[i]+"";
     String txtName = gpxName+"";
      String extT = "txt";
      
      txtName=txtName.substring(0,txtName.length()-3);
      txtName+=extT;
      println(gpxName);

      String [] tmp = (splitTokens(gpxName,"."));
      String parsedName = tmp[0]+"";
      GPSTrack trk = new GPSTrack(this,path,gpxName,parsedName);
      String[] textFileStrings=loadStrings(path+txtName);
      String nam = parsedName+"";
      Person newPerson = new Person (textFileStrings, trk,nam,cnt);

      persons = (Person[])expand(persons,persons.length+1);
      persons[persons.length-1] = newPerson;
      cnt2++;
      println(parsedName+" loaded");
    }// end txt if
  }// end loop*/
}


