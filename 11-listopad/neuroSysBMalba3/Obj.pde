/**neuron object*/

//-----------------------  >

class Neuron{
  PApplet parent;
  float x,y;
  float tx,ty;
  float sx,sy;
  int id;
  float tol = 30;
  float radius = 7;
  float distance;
  float speed = 100.0;
  float koef;
  float koefDet = 30.0;
  float border = 80.0f;
  float angle;
  float[] xM = new float[30];
  float[] yM = new float[30];
  int xCnt = 0;
  boolean touch;
  
  //-----------------------  >
  
  Neuron(PApplet _parent,float _x,float _y,float _koef,float _br,float _radius,int _id){
    speed=speeD;
    parent=_parent;
    id=_id;
    koef=_koef;
    tx=x=_x;
    ty=y=_y;
    for(int i = 0;i < xM.length;i++){
      xM[i] = x;
      yM[i] = y;
    }
    border=_br;
    radius = _radius;
  }

//-----------------------  >

  void run(){
    touch = false;     
    //if(id==0){fade(0,55);}
    compute();
    if(sysShow){
    drw(#FFFFFF,#000000);
    }
    border(80.0);
    
    //speed=map(neuro[33].x,bMin,width-bMin,20.0f,120.0f);    
  }

//-----------------------  >

  void reset(){
 
  }

//-----------------------  >

  void compute(){
   //   radius+=0.01;
     
    for(int i = 0;i<neuro.length;i++){
      distance = dist(x,y,neuro[i].x,neuro[i].y);
      distance = constrain(distance,1.1,sq(width));
      if((i!=id)&&(distance<tol)&&(distance>radius)) {
        tx += (neuro[i].x-tx)/(distance*koefDet);
        ty += (neuro[i].y-ty)/(distance*koefDet);  
      }
      if((i!=id)&&(distance<radius)){
        
        lin(i,id);
        if(sysShow){
        drw(#FFFFFF,0);
      }
        tx -= (neuro[i].x-x)/koef;
        ty -= (neuro[i].y-y)/koef;
      }

    }

    x+=(tx-x)/speed;
    y+=(ty-y)/speed;
    /*sx=abs(x-tx);
    sy=abs(y-ty);
    angle=atan2(sy,sx);*/
  } 

//-----------------------  >

  void drw(color s, color f){
    if(id==33){
      stroke(#FFFFFF,45);
    }else{
    stroke(s,25);
    }
    noFill();
        
         pushMatrix();
    translate(-bMin,-bMin);
    scale(0.75);
        
     for(int i = 0;i<xM.length;i++){
    line(xM[constrain(i-1,0,xM.length-1)],yM[constrain(i-1,0,xM.length-1)],xM[i],yM[i]);
    }
    
    popMatrix();
    
    ellipse(x,y,radius,radius) ;
    
     stroke(s,5);
     
      if(x>width/2.0){
    line(x,y,x+50,y);      
    }else{
      line(x-50,y,x,y);
    }
    
    if(y>height/2){
      line(x,y,x,y+50);    
    }else{
    line(x,y-50,x,y);
    }
  }
  
  //-----------------------  >
  
  void border(float kolik){
   if(x<kolik+radius/2){x=kolik+radius/2;}
  if(x>width-kolik-radius/2){x=width-kolik-radius/2;} 
    if(y<kolik+radius/2){y=kolik+radius/2;}
    if(y>height-kolik-radius/2){y=height-kolik-radius/2;}
  }
  
  //-----------------------  >
  
  void lin(int I,int II){
    touch = true;
    if(sysShow){
    stroke(#FFFFFF,85);
    line(neuro[I].x,neuro[I].y,neuro[II].x,neuro[II].y);
    stroke(#FFFFFF,25);
    line(x,25,x,35);
    line(25,y,35,y);
    
      //-mini react
    pushMatrix();
    translate(-bMin,-bMin);
    scale(0.75);
    
       
    line(x-2,y,x+2,y);
    line(x,y+2,x,y-2);
    
    xM[xCnt]=x;
    yM[xCnt]=y;
    popMatrix();
    
    }
    
    xCnt ++;
    xCnt=xCnt%xM.length;
    
  
   
  }
  
  
}
