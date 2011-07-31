import processing.video.*;
int num = 6;

Movie a[];

void setup(){
  size(200,200,P3D);
  a = new Movie[num];
  
  for(int i =0;i<num;i++){
  a[i] = new Movie(this,"bird.mov");
  
  }
  
   for(int i =0;i<num;i++){
   a[i].loop();
   }
 
  
  
}

void draw(){
  for(int i =0;i<num;i++){
  
  
 if( a[i].available() ){
  image(a[i],i*a[i].width,0);
 }
  } 
  
}

void movieEvent(Movie m){
  m.read();
}




class Flock{


}

class Bird{
  float x,y,z;
  float sx,sy,sz;
  int id;
  
  Bird(int id){
    
  }


}
