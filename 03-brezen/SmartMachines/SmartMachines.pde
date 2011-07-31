Machine mech;

void setup(){
  size(400,400,P3D);
  mech = new Machine(20);
  background(255);
}

void draw(){  
  //background(255);
  mech.run();  
}



class Machine{
  Tykadlo[] t;
  float x,y;

  Machine(int num){
    t=new Tykadlo[num];
    for(int i = 0;i<num;i++){
      t[i] = new Tykadlo(this,i);
    } 
  }

  void run(){
    compute();
    draw(); 
  }

  void compute(){
    x=mouseX;
    y=mouseY;
  }

  void draw(){
    for(int i = 0;i<t.length;i++){
      t[i].run();
    }
  }

}

class Part{
  Machine p;
  float x,y;
  float wx,wy;
  float speed = 10.0;
  int id;
  float radius;
  float theta = 0.0;
  float dista;
  float blowin;
  color c = color(0);

  Part(Machine parent,int id){
    p=parent;
    this.id=id;
    x=p.x;
    y=p.y;
  }

  void run(){
    compute(); 
    draw();
  }

  void compute(){
    dista = constrain(dist(p.x,p.y,x,y),1.5,1000);
    dista = map(dista,1,width,10,1);
    x+=(p.x+wx-x)/(speed);
    y+=(p.y+wy-y)/(speed);
    theta+=0.01*blowin;
  }

  void draw(){
    fill(c,5);
    noStroke();
    //line(p.x,p.y,x,y);
    ellipse(x,y,radius*sin(theta),sin(theta)*radius);
  }
}

class Tykadlo extends Part{

  Tykadlo(Machine p,int id){
    super(p,id);
    preset();
  }  
  void preset(){
    wx=random(-35,35);
    wy=random(-35,35);
    radius=random(5,50);
    speed = random(10,120); 
    blowin = random(-2,2);
    c=color(random(25,255));
  }
}
