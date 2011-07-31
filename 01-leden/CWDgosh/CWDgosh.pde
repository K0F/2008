import processing.opengl.*;

Cwd crowd;

void setup(){
  size(400,400,OPENGL);
  background(0);
  rectMode(CENTER);
  crowd = new Cwd(10);  
  textFont(loadFont("Uni0553-8.vlw"));
}


void draw(){
  background(0);
  crowd.run();

}

void mousePressed(){
  crowd.addNew(crowd.a.size(),mouseX,mouseY);

}

class Cwd{
  ArrayList a;
  int num;

  Cwd(int _num){
    num=_num;
    a = new ArrayList();
    for(int i = 0;i<num;i++){
      float x = random(width);
      float y = random(height);
      addNew(i,x,y);
    } 
  }

  void run(){
    for(int i =0;i<a.size();i++){
      Castice q = (Castice)a.get(i);       
      q.run(a);
    }
  }
  /*
  void addNew(int _id){    
   a.add(new Castice(a,_id));
   }
   */
  void addNew(int _id,float _x,float _y){    
    a.add(new Castice(a,_id,_x,_y));
  }

}

class Castice{

  float x,y,tx,ty,vel;
  int id,siz;
  boolean dens[][];
  float neighX[];
  float neighY[];
  float dista[];
  boolean contact[];
  float okruh;
  int last,cnt = 0;
  boolean another = false;

  Castice (ArrayList _a,int _id,float _x,float _y){
    id=_id; 
    x=tx=_x;
    y=ty=_y;  
    siz=_a.size();
    vel = 40.0f;
    okruh = 50.0f;
  }

  void run(ArrayList a){
    compute(a);

  }

  void compute(ArrayList a){
    siz = a.size();
    neighX = new float[siz];
    neighY = new float[siz];
    dista = new float[siz];
    contact = new boolean[siz];

    last = cnt;
    cnt = 0;

    for(int i =0;i<siz;i++){

      another = true;
      if(i==id){
        another = false; 
      }

      Castice neigh = (Castice)a.get(i);
      neighX[i]=neigh.x;
      neighY[i]=neigh.y;

      dista[i]=dist(neigh.x,neigh.y,x,y);


      
      if((another)&&(dista[i]<okruh)){
        contact[i]=true;

        if(dista[i]<okruh){
          tx+=(neigh.x-tx)/vel;
          ty+=(neigh.y-ty)/vel;        
          cnt++;
        }

        if(dista[i]<okruh*0.90){          
          
          float force = map(dista[i],okruh*0.3,okruh*0.99, 0 , 1);
          force = constrain(force,0.3,0.99);
          
          tx-=(neigh.x-tx)/(vel*force);
          ty-=(neigh.y-ty)/(vel*force);       

        }
        
      
        
      }


    }

    bordr(15);

    x+=(tx-x)/vel;
    y+=(ty-y)/vel;

  //  tx+=(x-tx)/(vel*.5);
   // ty+=(y-ty)/(vel*.5);

    draw(cnt);
  }

  void draw(int _cislo){
    for(int i =0;i<siz;i++){
      if(contact[i]){
        stroke(255,0,0,norm(dista[i],okruh*0.99,okruh*0.76)*35.0); 
      }
      else{
        stroke(255,norm(dista[i],width*1.14,0)*5.0);
      }

      line(neighX[i],neighY[i],x,y);

    }
    fill(255);
    noStroke();
    rect(x,y,1,1);
    text(_cislo,(int)x,(int)y);
  }

  void bordr(int _b){
    if(x< _b) x = tx = _b;
    if(y < _b) y = ty =_b;
    if(x>width-_b) x = tx = width-_b;
    if(y>height-_b) y = ty = height-_b;
  }


}
