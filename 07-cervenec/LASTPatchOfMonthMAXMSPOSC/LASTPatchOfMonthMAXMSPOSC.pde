import processing.opengl.*;

OSC osc;
int num = 4;
Node[] nodes;

void init(){
 frame.setUndecorated(true);
super.init(); 
}

void setup(){
  size(300,200,OPENGL);
  cursor(CROSS);
  frame.setLocation(300,10);
  
  
  background(0);
  smooth();

  textFont(loadFont("Tahoma-9.vlw"));

  osc = new OSC("127.0.0.1",12000);

  nodes = new Node[num];

  for(int i = 0;i<nodes.length;i++){
    nodes[i] = new Node(random(15,width-15),random(15,height-15),i);    
  }
  
  osc.send(5,1);
}

void draw(){
  background(0);
  for(int i = 0;i<nodes.length;i++){
    nodes[i].run();
  }
   stroke(#FF2222,200);
  line(centX(),0,centX(),height);
  line(0,centY(),width,centY());
}

float centX(){
  float an = nodes[0].x;
  for(int i = 1;i<nodes.length;i++){
    an+=nodes[i].x; 
  }
  an/=nodes.length;
  return an; 
}

float centY(){
  float an = nodes[0].y;
  for(int i = 1;i<nodes.length;i++){
    an+=nodes[i].y; 
  }
  an/=nodes.length;
  return an; 
}

void mousePressed(){
  for(int i = 0;i<nodes.length;i++){
    
    for(int q = 0;q<nodes[i].subs.length;q++){
     if(nodes[i].subs[q].over()&&mouseButton==LEFT){
      nodes[i].subs[q].locked=true; 
      break;
    }
    }
    
    if(nodes[i].over()){
      if(mouseButton==LEFT){
        nodes[i].locked=true;
        break;
      }
      else if(mouseButton==RIGHT){
        nodes[i].addSubNode(); 
        //println("Node "+i+" has "+nodes[i].subs.length+" subnodes");
      }
    } 
  } 
}

void stop(){
 osc.send(5,0);
super.stop(); 
}



void mouseReleased(){  
  for(int i = 0;i<nodes.length;i++){
     nodes[i].locked=false;
    
    for(int q = 0;q<nodes[i].subs.length;q++){
    nodes[i].subs[q].locked=false;
    
    }
   
  }   
}




