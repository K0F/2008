import interfascia.*;

GUIController c;
IFTextField t;
IFLabel l;
boolean ruin = false;
boolean hide = false;
int boxY;
float boxTY;
int Ybas;
int x;


void setup() {
  size(400, 100);
  background(150);

  c = new GUIController(this);
  t = new IFTextField("Text Field", 25, 30, 350);
  l = new IFLabel("", 25, 70);

  c.add(t);
  c.add(l);

  t.addActionListener(this);
  
  Ybas=t.getY();

}

void draw() {
  background(255);
  x--;
  if(x<-100){
   x=width+100;     
  }
  l.setX(x);

  String q = "";
  if(ruin){
    for(int i = 0;i<30;i++){
      q+=((char)(int)random(46,155));
    }  
    t.setValue(q);
  }
  
  
  
  boxY+=(int)((boxTY-boxY)/20.0f);
  t.setY(boxY);
}

void mousePressed(){
  if(mouseButton==RIGHT){
    if(!ruin){
      ruin=true;
    } 
    else{

      ruin=false;
    }
  }
}

void keyPressed(){
  if(keyCode==DOWN){
     boxTY=height+t.getHeight(); 
  }
  else if(keyCode==UP){
     boxTY=Ybas;

  } 

}

void actionPerformed(GUIEvent e) {
  if (e.getMessage().equals("Completed")) {
    l.setLabel(t.getValue());
    println(t.getValue());
    t.setValue("");
  }
}
