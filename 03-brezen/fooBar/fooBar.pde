import processing.opengl.*;

A[] a;
int num = 20;

void setup(){
 size(800,600,OPENGL);
 noStroke();
  a = new A[num]; 
  for(int i = 0;i<a.length;i++){
   a[i] = new A(random(width),random(height),i);   
  }
  
  textFont(createFont("Arial",9));
  
  //smooth();
  rectMode(CENTER);
  background(0);
}

void reset(){
 for(int i = 0;i<a.length;i++){
   a[i] = new A(random(width),random(height),i);   
  }  
}

void mousePressed(){
 if(mouseButton==LEFT){
  reset();
 } 
 
mousePressed=false;
}

void draw(){
  background(0);  
  
  for(int i = 0;i<a.length;i++){
   a[i].draw();   
  }
  
}
