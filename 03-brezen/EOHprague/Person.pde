class Person {
  GPSTrack track;
  Star fixedStars[];
  MovingStar movingStar;
  float Lat[],Lon[];
  float sizes[];
  float txtLon[],txtLat[];
  int id;  
  //////////////// visual ///
  boolean visual = true;
  float zoom = 0; 
  int siz[];
  color c;

  //////////////////
  String name;


  Person (String pointsString[], GPSTrack _track,String _name,int _id) {
    id=_id;
    track = _track;
    name=_name+"";
    Lat = new float[track.points.length];
    Lon = new float[track.points.length];
   
    txtLat = new float[pointsString.length];
    txtLon = new float[pointsString.length];
    sizes = new float[pointsString.length];
    fixedStars = new Star[pointsString.length];

    c = color(random(128,255),random(128,255),
    random(128,255));
    textFont(createFont("Veranda",9));

    // movingStar = new Star(track.lon,track.lat,siz,k);

    //// reading from xmls ///////////////////////// >
    for (int i = 0; i < Lat.length; i++) {
      Lat[i] = track.lat[i];
      Lon[i] = track.lon[i];
      //fixedStars[i] = new Star(Lon[i],Lat[i],30,this);
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
    //println(Lat);
  }

  void draw(){
	  visual=VIZ;
	  
    for (int i=0; i < fixedStars.length; i++) {
      stroke(255,55);
      fixedStars[i].run();
    }
    movingStar.run();
  }

  float lon0(){
    float lats = Lat[0];
    for(int i = 0;i<Lat.length;i++){
      lats+=Lat[i]/2.0;
    }
    return lats;
  }

  float lat0(){
    float lons = Lon[0];
    for(int i = 0;i<Lon.length;i++){
      lons+=Lon[i]/2.0;
    }
    return lons;
  }


}
