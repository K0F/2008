PdReader n;

void setup(){ 
  size(n.mainResX,n.mainResY);
  background(255); 
  
  textFont(createFont("Tahoma",9));
  //smooth();
  
  frame.setTitle("PD viewer");

}

void init(){
   n = new PdReader("rev1~-help.pd");
   super.init();
  
}


void draw(){
  background(35);
  n.run();
}


void mouseReleased(){
  for(int i = 0;i<n.drag.length;i++){
    n.drag[i] = false;
  }
}


