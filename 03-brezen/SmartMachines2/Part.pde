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
    fill(c,25);
    noStroke();
    //line(p.x,p.y,x,y);
    ellipse(x,y,radius*sin(theta),sin(theta)*radius);
    stroke(0,15);
    point((x+radius*sin(theta)*2),y);
    point(-(x+radius*sin(theta)*2),y);
    point(x,(y+radius*sin(theta)*2));
    point(x,-(y+radius*sin(theta)*2));
  }
}
