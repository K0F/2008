/**
//// class of stationary "fixedStar" objects  //////////////////// >
*/

class Star{
  EarthOnHeaven parent;
  float x,y;

  int id;
  float lon,lat;
  float siz;
  Person p;
  int no;
  color c,_alph;
  boolean first = true;
  float distance,latDistance;
  PImage msk,img;

  Star(float _lon,float _lat,float _siz,color _c,Person _p){

    p = _p;
    this.parent = p.parent;
    c=_c;
    lon = _lon;
    lat = _lat;
    siz = _siz;

    msk = loadImage("texture10.gif");
    img = new PImage(msk.width,msk.height);
    for (int i = 0; i < img.pixels.length; i++) img.pixels[i] = color(255);
    img.mask(msk);
  }

  void run(){
    if(first){
      compute();
      first=false;
    }
    draw();

  }
  void draw(){

    //// distance in screen numbers ////////////////// >
    distance = dist(p.movingStar.x,p.movingStar.y,x,y);
    //// distance in real numbers ////////////////// >
    latDistance = dist(p.movingStar.lon,p.movingStar.lat,lon,lat);
    drawStar();	   
  }

  void drawStar(){
    float size = map(siz,0.5,5,12,30);
    float a,r,g,b,w;

    a=random(6,10);//colour and alpha
    r=random(30,55);
    g=random(150,170);
    b=random(230,255); 
    w=random(190,255);
    fill(r,g,b,a);
    noStroke();
    ellipse(x,y,size+6,size+6);  


    for (int q=0;q<=size;q++)
    {  
      fill(w,size-q);
      ellipse(x,y,q,q);
    }



  }



  void compute(){
    x = parent.globScaleX(lon);
    y = parent.globScaleY(lat);
  }

  //////////////////////////////////
  //////////////////////////////////
  //// fixed star draw

}

/**
//// class of moving star //////////////////// >
*/
class MovingStar{
  ParticleSystem ps;
  EarthOnHeaven parent;
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
    this.parent = p.parent;
    lons = new float[_lons.length];
    lats = new float[_lons.length];
    lon = _lons[0];
    lat = _lats[0];
    xs = new float[_lons.length];
    ys = new float[_lons.length];

    speed = parent.globSpeed;

    for (int i=0; i < _lats.length; i++) {
      lons[i] = _lons[i];
      lats[i] = _lats[i];
    }
    c = _c;


    PImage msk = loadImage("texture10.gif");
    PImage img = new PImage(msk.width,msk.height);
    for (int i = 0; i < img.pixels.length; i++) img.pixels[i] = color(255);
    img.mask(msk);

    ps = new ParticleSystem(0,new Vector3D(width/2,height-20),img);

  }

  void run(){
    if(first){
      scaleXYs();
      x=xs[0];
      y=ys[0];
      first=false;
    }

    compute();
    drawParticles();

  }

  //////////////////////////////////
  //////////////////////////////////
  //// moving star draw
  void drawParticles(){

    // Calculate a "wind" force based on mouse horizontal position
    float dx = (x - width/2) / 1000.0;
    Vector3D wind = new Vector3D(dx,0,0);
    //ps.add_force(wind);
    ps.origin=new Vector3D(x,y);
    ps.run();

    for (int i = 0; i < 2; i++) {
      ps.addParticle();
    }


  }

  void scaleXYs(){
    for (int i=0; i < lats.length; i++) {
      xs[i] = parent.globScaleX(lons[i]);
      ys[i] = parent.globScaleY(lats[i]);
    }
  }



  void compute(){

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




}





