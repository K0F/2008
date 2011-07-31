//// class of stationary "fixedStar" objects  //////////////////// >
class Star{
  float x,y;
  int id;
  int w;
  float lon,lat;
  float lon0,lat0;
  float siz;
  Person p;
  int no;
  color c,_alph;
  boolean first = true;
  float distance,latDistance;

  Star(float _lon,float _lat,float _siz,color _c,Person _p){
    p = _p;
    c=_c;
    lon = _lon;
    lat = _lat;
    siz = _siz;

    lon0=p.lon0();
    lat0=p.lat0();
    //println(p.lon0());

  }

  void run(){
    if(first){
      compute();
      first=false;
    }
    draw();
    //println(x+" : "+y);
    //println(lon+" "+min(p.Lon)+" "+max(p.Lon));
  }
  void draw(){
    //// distance in screen numbers ////////////////// >
    distance = dist(p.movingStar.x,p.movingStar.y,x,y);
    //// distance in real numbers ////////////////// >
    latDistance = dist(p.movingStar.lon,p.movingStar.lat,lon,lat);		

    if(p.visual){
      singleStar((int)(siz*10));
    }
    else{

      stroke(255,constrain(map(distance,30,180,128,15),45,255));
      
      //// when comes to range fill that ellipse //////// >
      if(latDistance<0.002){
        fill(255,norm(latDistance,0.02,0.0)*70);
        }
      else{
        noFill();
      }
      
      line(x+10,y,x-10,y);
      line(x,y-10,x,y+10);
      ellipse(x,y,distance*2.0,distance*2.0);
      noStroke();
      fill(c,constrain(map(distance,30,180,128,15),45,255));
      text(lon+" "+lat,(int)x+5,(int)y);

    }
  }

  void compute(){
    x = globScaleX(lon);
    y = globScaleY(lat);
    //y = scaleY();
    //scaleTest();
  }

  void drawStar(){
    w=int(random(180,200));
    for (int CtrS=0;CtrS<=siz;CtrS++){
      noStroke();
      fill(w,siz-CtrS);
      ellipse(x,y,CtrS,CtrS);
    }
  }

  void singleStar(int _size){


    _alph = (int)random(50,75);

    noStroke();
    for(int i =0;i < _size ;i+=2){			
      fill(255,norm(_size-i,0,_size)*_alph);
      ellipse(x,y,i,i);
    }

  }

}


//// class of moving star //////////////////// >
class MovingStar{
  float lons[],lats[];
  float lon, lat;
  float xs[],ys[];
  int which = 0;
  float x,y;
  float speed = 30.0;
  color c;
  Person p;
  boolean first = true;

  MovingStar(float[] _lons,float[] _lats,color _c,Person _p){
    //println(_lons);
    p=_p;
    lons = new float[_lons.length];
    lats = new float[_lons.length];
    lon = _lons[0];
    lat = _lats[0];
    xs = new float[_lons.length];
    ys = new float[_lons.length];

    for (int i=0; i < _lats.length; i++) {
      lons[i] = _lons[i];
      lats[i] = _lats[i];
    }
    c = _c;
    x=width/2;
    y=height/2;
  }

  void run(){
    if(first){
      scaleXYs();
      first=false;
    }
    compute();
    if(p.visual){
      stroke(255,120);
      fill(255,30);
      ellipse(x,y,20,20);
    }
    else{			
      draw();
    }
  }

  void scaleXYs(){
    for (int i=0; i < lats.length; i++) {
      xs[i] = globScaleX(lons[i]);
      ys[i] = globScaleY(lats[i]);
    }
  }

  void drawTrail(){
    beginShape();
    noFill();
    for(int i =0;i<xs.length;i++){
      stroke(c,constrain(norm(abs(i-which),20,0)*155,55,255));
      vertex(xs[i],ys[i]);
    }
    endShape();
  }

  void compute(){
    speed=globSpeed;
    //// abstract x y /////////// >
    x+=(xs[which]-x)/speed;
    y+=(ys[which]-y)/speed;

    //// real coords lat lon /////////// >
    lon+=(lons[which]-lon)/speed;
    lat+=(lats[which]-lat)/speed;

    //// looping /////////// >
    if(dist(x,y,xs[which],ys[which])<1){
      which++;
      which=which%lons.length;
    }
  }

  void draw(){
    drawTrail();
    stroke(c,80);
    fill(c,35);
    ellipse(x,y,10,10);
    fill(c,150);
    text(p.name,(int)x+10,(int)y);
    text(lon+" :: "+lat,(int)x+10,int(y+12));
  }


}





