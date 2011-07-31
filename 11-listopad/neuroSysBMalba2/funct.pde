//-----------------------  >

void mousePressed(){
  if(sysShow){
  fullRest();
  }else{
   colGen2();    
  }
}

void colGen(){
   for(int i = 0;i<neuro.length;i++){
    neuro[i] = new Neuron(this,random(bMin,bMax),random(bMin,bMax),1,bordr,radi,i);
    farby[i] = color(random(25,255),random(25,255),random(25,255));
} 
}

void colGen2(){
   for(int i = 0;i<neuro.length;i++){
	farby[i] = lerpColor(color(255),color(random(120,255),random(100,255),0),random(100)/100.0);
	
} 
}

void colGen3(){
   for(int i = 0;i<neuro.length;i++){
    farby[i] = color(random(25,255));
} 
}

//-----------------------  >

void fullRest(){
  for(int i = 0;i<neuro.length;i++){
    neuro[i].tx = random(bMin,bMax);
    neuro[i].ty = random(bMin,bMax);
  } 

}

//random(bMin,bMax);

void chosen(int f,int s,int t,int fo){
   rect(neuro[f].x-neuro[f].radius/2,neuro[f].y-neuro[f].radius/2,neuro[f].radius,neuro[f].radius);
  rect(neuro[s].x-neuro[s].radius/2,neuro[s].y-neuro[s].radius/2,neuro[s].radius,neuro[s].radius); 
  rect(neuro[t].x-neuro[t].radius/2,neuro[t].y-neuro[t].radius/2,neuro[t].radius,neuro[t].radius); 
  rect(neuro[fo].x-neuro[fo].radius/2,neuro[fo].y-neuro[fo].radius/2,neuro[fo].radius,neuro[fo].radius);
  beginShape(QUADS);
  fill(#FFCC00,25);
  vertex(neuro[f].x,neuro[f].y);
  vertex(neuro[s].x,neuro[s].y);
  vertex(neuro[t].x,neuro[t].y);
  vertex(neuro[fo].x,neuro[fo].y); 
  endShape(CLOSE);
}

void last(){

  int L = left();
  int R = right();
  int U = up();
  int B = bottom();

  rect(neuro[L].x-neuro[L].radius/2,neuro[L].y-neuro[L].radius/2,neuro[L].radius,neuro[L].radius);
  rect(neuro[R].x-neuro[R].radius/2,neuro[R].y-neuro[R].radius/2,neuro[R].radius,neuro[R].radius); 
  rect(neuro[U].x-neuro[U].radius/2,neuro[U].y-neuro[U].radius/2,neuro[U].radius,neuro[U].radius); 
  rect(neuro[B].x-neuro[B].radius/2,neuro[B].y-neuro[B].radius/2,neuro[B].radius,neuro[B].radius);
  beginShape();
  fill(0,55);
  vertex(neuro[L].x-neuro[L].radius/2,neuro[L].y-neuro[L].radius/2);
  vertex(neuro[U].x-neuro[U].radius/2,neuro[U].y-neuro[U].radius/2);
  vertex(neuro[R].x-neuro[R].radius/2,neuro[R].y-neuro[R].radius/2);
  vertex(neuro[B].x-neuro[B].radius/2,neuro[B].y-neuro[B].radius/2); 
  endShape(CLOSE);
}

int left(){
  float val = width;
  int which = 0;
  for(int i = 0;i<neuro.length;i++){
    if(val>neuro[i].x){
      val = neuro[i].x;
      which = i;
    }
  }  
  return which;
}

int right(){
  float val = 0;
  int which = 0;
  for(int i = 0;i<neuro.length;i++){
    if(val<neuro[i].x){
      val = neuro[i].x;
      which = i;
    }
  }  
  return which;
}

int up(){
  float val = width;
  int which = 0;
  for(int i = 0;i<neuro.length;i++){
    if(val>neuro[i].y){
      val = neuro[i].y;
      which = i;
    }
  }  
  return which;
}

int bottom(){
  float val = 0;
  int which = 0;
  for(int i = 0;i<neuro.length;i++){
    if(val<neuro[i].y){
      val = neuro[i].y;
      which = i;
    }
  }  
  return which;
}

void fade(color _t,int _f){
  noStroke();
   fill(_t,_f);
  rect(0,0,width,height);
  //rect(bMin-5,bMin-5,10+width-bMin*2,10+height-bMin*2);


}

void tick(int q){
   tickC++;
    
  }
  
  
