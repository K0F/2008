
int number = 10;
Node[] node;

void setup(){
  size(400,400);
  background(255);
  textFont(createFont("Tahoma",9));
  textAlign(CENTER);
  node = new Node[number];
  for(int i = 0;i<number;i++){
    node[i] = new Node(i);
  } 
  smooth();

}

void draw(){
  background(255);
  for(int i = 0;i<node.length;i++){
    node[i].run();
  } 
}

void mousePressed(){

  for(int i = 0;i<node.length;i++){
    if(node[i].over()){

      if(mouseButton==LEFT){
        node[i].addLetter();
      } 
      else if(mouseButton==RIGHT){
        node[i].deleteLetter(); 
      }
      break;
    }
  }

}


class Node{
  String dna = "";
  int num = 5;
  float x,y,rx,ry;
  float globTheta = 0;
  int id;
  float speed = 100.0f;
  float radi;
  float tol = 0.5f;

  Node(int _id){
    id = _id;
    for(int i = 0;i<num;i++){
      addLetter(); 
    }
    x=random(width);
    y=random(height);    
  }

  void run(){
    position();
    draw(); 
  }

  void position(){
    radi = dna.length()*8;
    for(int i = 0;i<node.length;i++){
      if(i!=id){
        float distn = dist(node[i].x,node[i].y,x,y);
        if(distn < 1){
         // println("bang!");
          addLetter(); 
          node[i].x+=random(-radi*2,radi*2);
          node[i].y+=random(-radi*2,radi*2);
        }  
        else if(distn+tol < 0.5*(radi+node[i].radi)){
          x-=(node[i].x-x)/(speed/2.0f);
          y-=(node[i].y-y)/(speed/2.0f);

          if(node[i].dna.length()!=dna.length()){
            if(node[i].dna.length()<dna.length()){
              // node[i].addLetter(dna.charAt(dna.length()-1));
            }
          }
        }
        else if(distn-tol>(radi+node[i].radi)*0.5f){

          x+=(node[i].x-x)/(speed*2f);
          y+=(node[i].y-y)/(speed*2f);
        }    
      }     
    } 
    rx+=(x-rx)/speed;
    ry+=(y-ry)/speed;
    bordrs(1);

  }

  void bordrs(int k){
    if(x+radi/2>width-k) x=width-k-radi/2; 
    if(x-radi/2 < k) x= k+radi/2;
    if(y+radi/2>height-k) y=height-k-radi/2; 
    if(y-radi/2 < k) y= k+radi/2;

  }

  void draw(){
    noFill();
    stroke(0,75);
    ellipse(rx,ry,radi,radi);
    fill(0);
    text(dna,(int)rx,(int)ry+4);
    drawViz();
  }

  void drawViz(){
    globTheta+=radi*0.0003f;
    noFill();
    pushMatrix();
    translate(rx,ry);

    for(int i = 0;i<dna.length();i++){
      pushMatrix();
      rotate(globTheta+hashcode()[i]*10);
      line(0,0,sin(hashcode()[i])*((radi)/2),0);  
      ellipse(sin(hashcode()[i])*((radi)/2),0,10,10);
      popMatrix();  
    } 

    popMatrix(); 
  }

  void addLetter(){
    dna+=(char)((int)random(65,91))+""; 
  }

  void addLetter(char a){
    dna+=(char)a+""; 
  }

  void deleteLetter(){
    if(dna.length()-1>0){
      dna=dna.substring(0,dna.length()-1); 
    }
  }

  boolean over(){
    boolean q = false;
    if(dist(mouseX,mouseY,x,y)<((radi)/2)){
      q = true;
    } 
    return q;
  }

  int[] hashcode(){
    int q[];
    q = new int[dna.length()];

    for(int i = 0;i<q.length;i++){
      q[i] = parseInt(dna.charAt(i))-65; 
    }
    return q;
  } 

}
