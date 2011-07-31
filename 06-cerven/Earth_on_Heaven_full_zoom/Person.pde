/*
*  Person class is created for once per each gpx,txt file
 *  stores values of track and points inside as well as casting the particle system
 *
 */
class Person {
  EarthOnHeaven parent;
  GPSTrack track;

  Star fixedStars[];
  MovingStar movingStar;

  float Lat[],Lon[];
  float sizes[];
  float txtLon[],txtLat[];
  int id;   
  int siz[];
  color c; 
  String name;

  Person (String pointsString[], GPSTrack _track,String _name,int _id,EarthOnHeaven e) {
    parent=e;
    id=_id;
    track = _track;
    name=_name+"";
    Lat = new float[track.points.length];
    Lon = new float[track.points.length];
    //println("name: "+name+" id: "+id); 

    txtLat = new float[pointsString.length];
    txtLon = new float[pointsString.length];
    sizes = new float[pointsString.length];
    fixedStars = new Star[pointsString.length];

    c = color(random(128,255),random(128,255),
    random(128,255));    

    //// reading from xmls ///////////////////////// >
    for (int i = 0; i < Lat.length; i++) {
      Lat[i] = track.lat[i];
      Lon[i] = track.lon[i];     
    }

    //// reading from txts /////////////////////////// >
    for (int i=0; i < pointsString.length; i++) {
      String [] data = splitTokens(pointsString[i]," ");
      txtLon[i] = (float)parseFloat(data[1]);
      txtLat[i] = (float)parseFloat(data[2]);
      sizes[i] = (float)parseFloat(data[3]);
      Star newStar = new Star(txtLon[i],txtLat[i],sizes[i],c,this);
      fixedStars[i] = newStar;

    }
    movingStar = new MovingStar(Lon,Lat,c,this);    
  }

  void draw(){

    for (int i=0; i < fixedStars.length; i++) {
      stroke(255,55);
      fixedStars[i].run();
    }
    movingStar.run();
  }
}
