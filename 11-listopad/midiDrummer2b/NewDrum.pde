class Drummer{

  boolean rnd = false;
  boolean light = false;
  int num = 10;
 
  int[] seq;
  int cntr = 0;
  int dim = 255; 
  int x = 10;
  int y = 10;
  int id;
  
  Drummer(int _seq[]){
    seq = _seq;
    id = d.length-1;
  }
  
  void draw(){
   if(dim>0){dim-=20;}
  
  if(light){
  stroke(255);
  fill(255,155);
  }else{
    stroke(0,100);
  fill(0,55);
  }
  rect(x,y,seq.length*15+15,30);
  light = false;
    
  noStroke();
  fill(#FFCC00,dim);
  rect(seq.length*15+10+x,y+1,5,5);
  
  fill(#FFCC00);
  text(id,3+x,10+y);
  
    
  if(frameCount%rate==0){
    test.sendNote(new Note(seq[cntr],127,50));
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
 
    
  }
  
  boolean over(){
 boolean answ = false;
  if(mouseX>x&&mouseX<seq.length*15+15+x&&
  mouseY>y&&mouseY<y+30)
   answ=true;
  return answ; 
  
}

void setX(int _x){
  x=_x;
}

void setY(int _y){
 y=_y; 
}


}

