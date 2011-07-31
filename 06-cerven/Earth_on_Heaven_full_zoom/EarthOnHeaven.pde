

/**
 *  Main class holding variables, objects, and all of global functions inside
 *  
 */

class EarthOnHeaven{
  PApplet parent;
  /////////////////////////////////////////////////////////////////////////////////////
  //// main visualisation>> for stars TRUE, for debug FALSE //////////////////////// :: >
  boolean VIZ = true;
  //// address and port for osc sending  //////////////////////// :: >
  String address = "127.0.0.1"; //
  int port = 12000;
  /////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////

  //// create empty array of class person //////////////////////// :: >
  Person persons[] = new Person[0];

  //// OSC class for comunication with PD //////////////////////// :: >
  OSC osc;

  //// booleans for sending osc data //////////////////////// :: >
  boolean ready,sending = true;

  //// number of pesons gives each class its ID //////////////////////// :: >
  int cnt = 0;  

  //// centers of persons //////////////////////// :: >
  float centersLat[],centersLon[];

  //// centers of persons //////////////////////// :: >
  float globLon[],globLat[];

  //// center of the map //////////////////////// :: >
  float globCenterLat,globCenterLon;
  float globCenterLon2, globCenterLat2;

  //// number of all points loaded into application //////////////////////// :: >
  int allPoints = 0;

  //// globSpeed affect how much are the moving strars moving //////////////////////// :: >
  float globSpeed = 30.0;

  //global scale multiplier, scales between screen coords and the real one(K)
  //scale factor, the scale of the map (M)
  float k; 

  //centre of the screen (to avoid calculating it over and over insight the functions)
  float halfW=(width/2);
  float halfH=(height/2);

  EarthOnHeaven(PApplet _parent,String _address,int _port,float _globSpeed){
    //// get all inputs //////////////////////// :: >
    port=_port;
    address=_address;    
    parent=_parent;
    globSpeed = _globSpeed;


    println("\n/////////////////////////////////////////// OSC CAST\n");
    //// cast osc object //////////////////////// :: >
    osc = new OSC(address,port);   

    println("\n/////////////////////////////////////////// READING FILES\n");
    //// loading data from ./data/persons/ directory gpx and files needed //////////////////////// :: >
    //// each of .gpx file must have .txt file with a same name //////////////////////// :: >
    loadDataFromFiles2();

    //// computing the scale stuff from points loaded //////////////////////// :: >
    //// gets the value of all points in txt and gpx files //////////////////////// :: >
    allPoints = getNumberOfAllPointsLoaded();

    //// create empty arrays for storing them //////////////////////// :: >
    globLon = new float[allPoints];
    globLat = new float[allPoints];

    //// arrays for centers //////////////////////// :: >
    centersLat = new float[persons.length];
    centersLon = new float[persons.length];



    //// main scaling procedure running all of the scale functions at once //////////////////////// :: >
    scaleThat();

    //// debug console prints //////////////////////// :: >
    println("\n/////////////////////////////////////////// DATA SUMMARY\n");
    println("no. of persons: "+cnt);
    println("got "+allPoints+" points");
    println("min Lons: "+min(globLon)+" max Lon: "+max(globLon)+"  ambit:"+(abs(min(globLon)-max(globLon))));
    println("min Lats: "+min(globLat)+" max Lat "+max(globLat)+"  ambit:"+(abs(min(globLat)-max(globLat))));
    println("globalCenterX: "+globCenterLon2+"\nglobalCenterY: "+globCenterLat2);
    println("\n/////////////////////////////////////////// ALL DONE!");

    //// if you find any of empty value in the arrays means somethig is wrong //////////////////////// :: >
    for(int i =0;i<allPoints;i++){
      if(globLat[i]==0.0){
        println("noise on Lat:"+i);
      }
      if(globLon[i]==0.0){
        println("noise on Lon:"+i);
      }
    }

    noStroke();   
  }

  void draw() {    
    //// run the main drawing function here //////////////////////// :: >
    drawPersons();
  }

  //// function for runing all of person objects at once //////////////////////// :: >
  void drawPersons(){
    for (int i = 0; i < persons.length; i++) {
      //// draw person //////////////////////// :: >
      persons[i].draw();

      //// and send the data if sending enabled //////////////////////// :: >
      if(sending){
        osc.send(persons[i].id,persons[i].movingStar.lon,persons[i].movingStar.lat);
      }
    }
  }

  //// load and create persons here //////////////////////// :: >
  void loadDataFromFiles2(){
    //// relative path //////////////////////// :: >
    String path = sketchPath+"/data/persons/";

    //// cast java directory for browsing our persons dir //////////////////////// :: >
    File dir = new File(path);

    //// dir.listFiles() returns files in our directory //////////////////////// :: >
    File[] files = dir.listFiles();

    //// loop trought all files founded //////////////////////// :: >
    for( int i=0; i < files.length; i++ ){
      //// get the fileName //////////////////////// :: >
      String fileName = files[i].getName();

      //// if filename ends with gpx? //////////////////////// :: >
      if(fileName.endsWith("gpx")){
        //// get its name //////////////////////// :: >
        String gpxName = fileName+"";

        //// and look for a textfile //////////////////////// :: >
        String txtName = gpxName.substring(0,gpxName.length()-3)+"txt";//gpxName.replace("gpx", "txt");

        ////excrating the name without extension //////////////////////// :: >
        String [] tmp = (splitTokens(gpxName,"."));
        String parsedName = tmp[0]+"";


        //// cast GPSTrack which will parse data of gpx //////////////////////// :: >
        GPSTrack trk = new GPSTrack(parent,sketchPath+"/data/persons",gpxName);

        //// load Strings from the textfile //////////////////////// :: >
        String[] textFileStrings=loadStrings(path+txtName);

        //// finaly create the person which require the String[],GPStrack object, parsedName, and ID //////////////////////// :: >
        Person newPerson = new Person (textFileStrings, trk,parsedName,cnt,this);

        //// expand the array of persons //////////////////////// :: >
        persons = (Person[])expand(persons,persons.length+1);

        //// and add newly created one to the array //////////////////////// :: >
        persons[persons.length-1] = newPerson;

        println(parsedName+" loaded // person id = "+cnt);
        //// count ++ for each created //////////////////////// :: >
        cnt++;
      }// end txt if
    }// end loop
  }// end void


  //// scale functions below //////////////////////// :: >
  //// main scale loader //////////////////////// :: >
  void scaleThat(){
    colectAllPoints();

    globCenterLon2 = getGlobalCenter2()[0];//currently used
    globCenterLat2 = getGlobalCenter2()[1];

    k = getScaleFactor();
  }

  //// loop trought all persons and store their stars position in single array //////////////////////// :: >
  void colectAllPoints(){
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

  float[] getGlobalCenter2(){
    float centers[] = new float[2];
    centers[0]=(min(globLon)+max(globLon))/2.0;
    centers[1]=(min(globLat)+max(globLat))/2.0;
    return centers;
  }

  //// get total number of stars loaded in the array //////////////////////// :: >
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

  //////////////Calculate the scale factor////////////////////////// ::>
  float getScaleFactor(){
    float _k=1;// temlorary _k var
    float tempX[] = new float[allPoints];
    float tempY[] = new float[allPoints];
    float dx=0;//distance between smallest and largest x value - not important as a global value.. just computing k, so he just templorary
    float dy=0;//distance between smallest and largest y value - the same

    for(int i= 0;i<allPoints;i++){
      //array ehere the gographic coordinates temporarly converted into cartesian are saved
      tempX[i]=(globLon[i]-globCenterLon2);
      tempY[i]=(globLat[i]-globCenterLat2);
      //calculate the absolute distance between smallest and largest x value and the same for y
      dx=abs((max(tempX))-(min(tempX)));
      dy=abs((max(tempY))-(min(tempY))); 
    }

    //calculation of the scale factor
    return (min(width,height))/(max(dx,dy));
  }

  //// X convert the longitudes into x cartesian coordinates using Plate Carre cartographic projection //////////////////////// :: >
  float globScaleX(float _x){   
    return (_x-globCenterLon2)*k+halfW;  
  }

  //// Y convert the latitudes into y cartesian coordinates using Plate Carre cartographic projection //////////////////////// :: >
  float globScaleY(float _y){   
    return (globCenterLat2-_y)*k+halfH;     // flip in Y coord here so the north is on the top of the screen = crapy hack or genial elegant solution ? :-)
  }

}
