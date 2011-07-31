class Node{
  SubNode subs[] = new SubNode[0];
  
  float x,y;
  float tx,ty;
  float cx,cy;
  float qx,qy,dista;
  float radius = 12.0;
  float speed = 3.0;
  int time;
  int id;
  boolean locked = false;

  Node(float _x,float _y,int _id){
    x=_x;
    y=_y;
    id=_id;

    cx=tx=x;
    cy=ty=y;
    
    time=(int)random(50);
  }

  void run(){
    time++;
    compute();
    draw(); 
  }

  void compute(){
    if(locked){
     lock(); 
    }
    cx=x;
    cy=y;
    goToPoint();
    if(abs(cx-x)>0.0||abs(cy-y)>0.0){
      send();
    }    
  }

  void draw(){
    if(over()||locked){
      stroke(255,255);
      noFill();
      ellipse(x,y,radius*2,radius*2);
    }
    else{
      stroke(255,(sin(time*0.15)+1)*250);
      noFill();
      ellipse(x,y,radius*2,radius*2);
    }
    drawLines();
    text((char)(id+65),(int)x,(int)y);
    
    for(int i =0;i<subs.length;i++){
     subs[i].run(); 
    }
  }
  
 

  void drawLines(){
    stroke(#FFCC00,40);
    for(int i =0;i<num;i++){
      if(i!=id){
        qx = 0.5*(x+nodes[i].x);
        qy = 0.5*(y+nodes[i].y);
        dista = dist(x,y,nodes[i].x,nodes[i].y);
        text((int)dista,(int)qx,(int)qy);
        stroke(255,85);
        line(nodes[i].x,nodes[i].y,x,y);
        stroke(#FFCC00,25);
        ellipse(qx,qy,dista-radius*2,dista-radius*2);
        line(qx,qy,nodes[i].qx,nodes[i].qy);
      }
    } 
  }

  void goToPoint(){
    x+=(tx-x)/speed;
    y+=(ty-y)/speed;
  }

  void setTarget(float _1,float _2){
    tx = _1;
    ty = _2; 
  }

  boolean over(){
    boolean an = false;
    if(dist(mouseX,mouseY,x,y)<radius&&dist(mouseX,mouseY,x,y)<radius){
      an = true;
    } 
    return an;
  }
  
  void addSubNode(){
   subs = (SubNode[])expand(subs,subs.length+1);
   int actual = subs.length-1;
   subs[actual] = new SubNode(this,actual); 
  }

  void send(){
    osc.send(id,x,y);
  }
  
  void lock(){
    time=0;
   tx=mouseX;
   ty=mouseY; 
  }
}

class SubNode{
 Node parent;
 float x,y;
 float tx,ty;
 float bx,by;
 boolean locked = false;
 float radius;
 int id;
 
 SubNode(Node _parent,int _id){
  parent=_parent;
  id = _id;
  x=parent.x;
  y=parent.y;
  radius = 15;
  while(abs(tx)<parent.radius&&abs(ty)<parent.radius){
  tx=random(-80,80);
  ty=random(-80,80);
  }
  bx=tx;
  by=ty;
  
 }

void run(){
  compute();
 draw();
}

void compute(){
  if(locked){
     lock(); 
    }
 tx=(parent.x+bx);///2.0;
 ty=(parent.y+by);///2.0;
 x+=(tx-x)/5.0; 
 y+=(ty-y)/5.0; 
}

void draw(){
   if(over()||locked){
      stroke(255);
      noFill();
      
    }else{
 stroke(255,80);
 noFill();
    }
  line(parent.x,parent.y,x,y);
 ellipse(x,y,radius,radius);
fill(255,120);
text(id,(int)x-1,(int)y+3);
}

boolean over(){
    boolean an = false;
    if(dist(mouseX,mouseY,x,y)<radius&&dist(mouseX,mouseY,x,y)<radius){
      an = true;
    } 
    return an;
  }
  void lock(){
   bx=mouseX-parent.x;
   by=mouseY-parent.y; 
  }
  
  
}

