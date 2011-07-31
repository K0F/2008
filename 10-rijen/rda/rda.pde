void setup(){
  size(200,200);
  smooth();

}

void draw(){
  noStroke();
  fill(0,14);
  rect(0,0,width,height);


  pushMatrix();
  translate(width/2,height/2);
  pushMatrix();
  rotate(frameCount/130.0);
  stroke(255);
  line(-100,0,100,0);
  popMatrix();
  popMatrix();
}

