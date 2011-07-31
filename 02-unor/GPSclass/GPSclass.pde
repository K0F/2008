import processing.serial.*;
import gps.dk.itu.haas.GPS.*;
dk.itu.haas.GPS.GPS gps;

void setup(){
  
  gps  = new dk.itu.haas.GPS.GPS();
  
}



/*
class GPS{

  //// serial comm //////////////// >
  Serial com;

  //// data parse ///////////////// >
  //// $--GGA,hhmmss.ss,llll.ll,a,yyyyy.yy,a,x,xx,x.x,x.x,M,x.x,M,x.x,xxxx
  String[] message;
  int UTCtime;
  float lati;
  float longi;
  int fix;
  int noSat;
  int precision;
  float alt;
  float WGS84;
  int upDate;
  int referenceSation;
  String checksum = "";
  PApplet parent;
  
  GPS(PApplet _parent){
    parent = _parent;
    print("availible ports: ");
    println(Serial.list());
    com = new Serial(parent, Serial.list()[5],9600);
    
    if(com.available() > 0){
      println(com.read());
      message = split(""+com.read(),",");
      println(message);
    }
    
  }


}*/
