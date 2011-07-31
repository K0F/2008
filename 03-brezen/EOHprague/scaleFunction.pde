/*
there are the global scale functions
*/

//// main loader //////////////////// >
void scaleThat(){
  colectAllGPSPoints();
  getCentersOfEachPerson();
  getGlobalCenter();
}

//// loop trought all persons and store their stars position in single array //////////////////// >
void colectAllGPSPoints(){
  int gi = 0;
  for(int i = 0;i<persons.length;i++){
    for(int q = 0;q<persons[i].Lat.length;q++){
      globLat[gi] = persons[i].Lat[q];
      globLon[gi] = persons[i].Lon[q];  
      gi++;     
    }
     for(int q = 0;q<persons[i].txtLat.length;q++){
      globLat[gi] = persons[i].txtLat[q];
      globLon[gi] = persons[i].txtLon[q];  
      gi++;     
    }  
  }   
}

//// get the center of each person //////////////////// >
void getCentersOfEachPerson(){
  for(int i = 0;i<persons.length;i++){
    centersLat[i] = (max(persons[i].Lat)+min(persons[i].Lat))/2.0;
    centersLon[i] = (max(persons[i].Lon)+min(persons[i].Lon))/2.0;
  }
}

//// get the center of centers of persons //////////////////// >
void getGlobalCenter(){
  float _lon = centersLon[0],_lat = centersLat[0];
  for(int i = 1;i<centersLat.length;i++){
    _lon+=centersLon[i];
    _lat+=centersLat[i];
  }  
  _lon = _lon/centersLon.length;
  _lat = _lat/centersLon.length;

  globCenterLat = _lat;
  globCenterLon = _lon;  
  println("got "+allPoints+" points");
  println("global center ="+_lon+"  "+_lat);
}

//// get total number of stairs loaded in the array //////////////////// >
int getNumberOfAllPointsLoaded(){
  int answ = 0;
  for(int i = 0;i<persons.length;i++){
    for(int q = 0;q<persons[i].Lat.length;q++){
      answ++;
    }  

    for(int e = 0;e<persons[i].txtLat.length;e++){
      answ++;
    }
  }
  return answ;
}


float globScaleX(float _x){
  return map(_x,min(globLon),max(globLon),10-zoom,width*(aspect)-10+zoom);
}

//// global Y scale here //////////////////// >
float globScaleY(float _y){
  return map(_y,min(globLat),max(globLat),height-10+zoom,10-zoom);
}
