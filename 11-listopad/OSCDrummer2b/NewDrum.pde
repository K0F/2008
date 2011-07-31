class Drummer{

  boolean rnd = false;
  boolean light = false;
  boolean dragging = false;
  boolean mute = false;
  
  int num = 10;
 
  int[] seq;
  int cntr = 0;
  int dim = 255; 
  int x = 10;
  int y = 10;
  int ox,oy;
  int id;

//////////////////////////////////////////////////////////
  
  Drummer(int _seq[]){
    seq = _seq;
    id = d.length-1;
  }
  
  //////////////////////////////////////////////////////////
  
  void draw(){
   if(dim>0){dim-=20;}
  
  if(dragging){
    light=true;
     x=mouseX-ox;   
    y=mouseY-oy;
  }
  
  
  if(mute){
    stroke(255);
  fill(255,55);
  }else if(light){
  stroke(0);
  fill(0,135); 
  }else {
    stroke(0,100);
  fill(0,55);
  }
  rect(x,y,seq.length*15+15,30);
  light = false;
    
  noStroke();
  fill(#FFCC00,dim);
  rect(seq.length*15+10+x,y+1,5,5);
  
  
  
    
  if(frameCount%rate==0&&!mute){
    osc.send(id,(float)seq[cntr]);
    dim=255;
    cntr++;
    fill(255,0,0);
    if(cntr>=seq.length)cntr=0; 
  }
  
 for(int i = 0;i<seq.length;i++){
    if(i==(cntr+seq.length-1)%seq.length){stroke(255,0,0);fill(255,1,1,50);}else{stroke(255,155);fill(255,50);}
    rect(i*15+9+x,19+y,12,5);
    fill(255);
    text(seq[i],i*15+9+x,22+y);
  }
 
  fill(#FFCC00);
  text ((char)(id+65)+"  ["+id+"]",3+x,10+y);
  text(+seq.length,3+x,28+y);  
  }
  
  //////////////////////////////////////////////////////////
  
  boolean over(){
 boolean answ = false;
  if(mouseX>x&&mouseX<seq.length*15+15+x&&
  mouseY>y&&mouseY<y+30)
   answ=true;
  return answ; 
  
}

//////////////////////////////////////////////////////////

void setX(int _x){
  x=_x;
}

//////////////////////////////////////////////////////////

void setY(int _y){
 y=_y; 
}

//////////////////////////////////////////////////////////

void setOffset(){
 ox = mouseX-x;
 oy = mouseY - y; 
}

//////////////////////////////////////////////////////////


}

