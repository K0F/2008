int val = 0;
Recurser recu;

void setup(){
  size(800,300,P3D); 
  recu=new Recurser(width);
  stroke(255);
}

void draw(){
  background(0);
  recu.draw(); 
}




class Recurser{
  Recurser r;
  int id,m;
  int shift;
  float x,y,yfact;
  float ty,ty2;
  float konst = 8.0; //rychlost simulace
  float dev[] = {1.010,1.111,1.212,1.01}; //prubeh vlny

  Recurser(int _m){
    id=val;
    m=_m;
    ty=ty2=y = height/2.0;
    yfact=random(5,height/2);
    shift=0;//(int)(random(100));
    val++;
    if (val<=m){
      r = new Recurser(m);      
      print(id+", ");
    }
  }

  void draw(){   



    if((r!=null)){     
      compute();
      //if(id!=m-1)line(x,y,r.x,r.y);
      line(x,0,x,y);
      r.draw();
    }
  } 

  void compute(){
    ty2 += (pow(dist(mouseX,mouseY,x,y),1.5102)/10.0-y)/(konst*dev[0]);
    /*sin(r.y-y+random(random(-10.333),random(10.333))/3000.0)*1.1533;*/
    ty += (ty2-ty)/(konst*dev[1]);
    y += (ty-y)/(konst*dev[2]);
    y += (r.y-y)/(konst*dev[3]);
    x=id;
    limit();
  }

  void limit(){
    if(y<5)ty2=ty=y=5;
    if(y>height-5)ty2=ty=y=height-5; 

  }

}
