/*void init(){
  frame.setUndecorated(true);
  super.init();
}*/

boolean fading = false;

color a,b;
float fade = 0;
float speed = 30.0;

void setup(){
  size(400,200,P3D);
  //frame.setLocation(10,50);
  background(0);
  
  textMode(SCREEN);
  textFont(createFont("Arial",9));

  a = color(random(255),random(255),random(255));
  b = color(random(255),random(255),random(255));

}

void draw(){
  fade = map(sin(frameCount/speed)+1,0,2,0,1);
  if(fade<0.01){
    change(2);
  }
  else if(fade>0.99){
    change(1);
  }
  background(lerpColor(a,b,fade));
  color q = get(width-1,height-1);

  fill(0,80);
  stroke(255);
  rect(0,0,map(hue(q),0,255,0,width),10);
  rect(0,10,map(saturation(q),0,255,0,width),10);
  rect(0,20,map(brightness(q),0,255,0,width),10);
  fill(255,80);
  text("hue: "+hue(q),10,10);
  text("sat: "+saturation(q),10,20);
  text("brg: "+brightness(q),10,30);
  
  
  stroke(255);
   fill(255,0,0,80);
  rect(0,40,map(red(q),0,255,0,width),10);
   fill(0,255,0,80);
  rect(0,50,map(green(q),0,255,0,width),10);
   fill(0,0,255,80);
  rect(0,60,map(blue(q),0,255,0,width),10);
  fill(255,80);
  text("r: "+red(q),10,50);
  text("g: "+green(q),10,60);
  text("b: "+blue(q),10,70);
  
   
  
}

void change(int e){
  if(e == 1){
    a = color(random(255),random(255),random(255));
  }
  else if(e == 2){
    b = color(random(255),random(255),random(255));
  }
}
