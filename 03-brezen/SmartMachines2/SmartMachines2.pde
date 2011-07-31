//nothing smart about that

Machine mech;

void setup(){
  size(800,600,P3D);
  mech = new Machine(50);
  background(255);
}

void draw(){  
  //background(255);
  mech.run();  
}

void mousePressed(){
  if(mouseButton==LEFT){
    mech.locked = true;
  } 
  else if(mouseButton==RIGHT){
    background(255);
  }  
}

void mouseReleased(){
  mech.locked = false; 
}

void keyPressed(){
 if(keyCode==ENTER){
  saveFrame("screen####.png");
 } 
}



class Machine{
  Tykadlo[] t;
  float x,y;
  boolean locked = false;

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



class Tykadlo extends Part{

  Tykadlo(Machine p,int id){
    super(p,id);
    preset();
  }  
  void preset(){
    wx=random(-25,25);
    wy=random(-25,25);
    radius=random(5,50.5);
    speed = random(20,30); 
    blowin = random(-5,5);
    c=color(random(0,255));
  }
}
