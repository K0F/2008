class Biz{
  PGraphics p,q;
  float siz,speed;
  float _X;
  float _Y;

  Biz(float id){

    _X = X;
    _Y = Y;

    siz = 40*(pow(id,1.3)+1);//random(30,180);
    speed = id;//random(0.5,4);


    float x1 = siz;
    float y1 = siz;
    float x11 = 10;
    float y11 = siz;

    p = createGraphics(2*(int)siz,2*(int)siz,P3D);

    p.beginDraw();
    p.smooth();
    p.stroke(255,185);
    p.noFill();
    p.ellipse(siz,siz,siz*2-20,siz*2-20);
    p.ellipse(10,siz,10,10);
    //p.line(10,50,50,50);

    p.line(x1,y1,x11,y11);
    p.pushMatrix();
    p.translate(x11,y11);

    p.pushMatrix();
    p.rotate(atan2(y11-y1,x11-x1));
    p.line(0,0,-15,-2.5);
    p.line(0,0,-15,2.5);

    p.popMatrix();
    p.popMatrix(); 
    p.filter(BLUR,id);

    p.endDraw();

    // p.loadPixels();


    /*
    q = createGraphics(2*(int)siz,2*(int)siz,P3D);
     p.loadPixels();
     q.pixels=p.pixels;
     q.beginDraw();    
     q.filter(BLUR,id*2);
     q.endDraw();
     */
  } 

  void draw(){
    _X+=(X-_X)/(pow(speed,10)/100.0);
    _Y+=(Y-_Y)/(pow(speed,10)/100.0);

    pushMatrix();
    translate(_X+cos(frameCount/(speed*80))*siz,_Y+sin(frameCount/(speed*80))*siz);
    pushMatrix();
    rotate(radians(frameCount*speed));
    tint(255,0,0);
    //image(q,-p.width/2,-p.height/2);
    noTint();
    image(p,-p.width/2,-p.height/2);

    popMatrix();
    popMatrix(); 

  }

}


