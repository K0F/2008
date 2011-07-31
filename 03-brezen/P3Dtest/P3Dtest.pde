

void setup(){
  size(400,200,OPENGL);

}
int cnt = 0;
float theta = 100.0f;
float theta2 = 100.0f;
float theta3 = 100.0f;
float theta4 = 100.0f;

void draw(){
  theta+=(mouseX-pmouseX)/50.0;
  theta2 += (theta-theta2) / 100.0;
  theta3+=(mouseY-pmouseY)/50.0;
  theta4 += (theta3-theta4) / 100.0;
  
  background(255);
  noFill();
  stroke(0,15);
  pushMatrix();
  translate(width/2,height/2);
  pushMatrix();
  rotateY(theta2);
  rotateX(-theta4);
  pushMatrix();
  translate(-80,0);
  sphere(sin(theta/20.0f)*40);
  translate(80,0);
  sphere(60);
  translate(0,8);
  sphere(120);
  popMatrix();
  sphere(80); 
  popMatrix();
  popMatrix();
}                                                           
