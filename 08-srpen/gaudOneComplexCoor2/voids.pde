/// ----------------- hmotnost, tuhost, pruznost, vule
float params[] = { 1.0,1.0,0.10,0.01};
/// ----------------- hmotnost, tuhost, pruznost, vule

void reint(int kolik){  
  snura = new SnuraPhy[0];
  
  
  
  for(int i = 0;i<cr.A.length;i++){
    snura = (SnuraPhy[])expand(snura,snura.length+1);
    snura[snura.length-1] = new SnuraPhy(i, (int)(cr.getWeight(i)*10+1) ,
    ps[cr.returnNeighs(i)[0]],
    ps[cr.returnNeighs(i)[1]],
  params[0],params[1],params[2], params[3],
  cr.getSolo(i));
    
  }

}
 // -----------------------------------------------------  >

void addLev(int A,int B){

  int parA = snura[A].returnLowest();
  int parB = snura[B].returnLowest();
  Particle[] tmp = {
    snura[A].particles[parA],snura[B].particles[parB]        };

  int parents[] = {
    A,B        };

  // println(A+" lowestPoint @ "+parA);
  //   println(B+" lowestPoint @ "+parB);
  //println("2");

  snura = (SnuraPhy[])expand(snura,snura.length+1);
  snura[snura.length-1] = new SnuraPhy(snura.length-1,tmp,
  snura[0].particles.length,
  ps[ps.length-1],ps[ps.length-2],
  params[0],params[1],params[2],params[3]);
}

// -----------------------------------------------------  >

void reload(){
  cr = new GeomParser("klenba.geom");
  ps = new Point[cr.pocetP()];
  SX=new float[ps.length];
  SY=new float[ps.length];
  SZ=new float[ps.length];

  for(int i = 0; i<ps.length;i++){    
    ps[i] = new Point( cr.getCoordinates(i)[0],
    cr.getCoordinates(i)[1],
    cr.getCoordinates(i)[2], i );
  }    
  println("coords loaded");
  physics = new ParticleSystem( gravity, 0.2 );
  reint(11);
  
  
  writer = new Writer();

}


// -----------------------------------------------------  >

void transform(){
  if(!selecting){
    rotX+=0.2*(mouseX-rotX);
    zoom += 0.08*(mouseY-zoom);
  }
  else{
    rotX+=0.0002*(mouseX-rotX);
    zoom += 0.00008*(mouseY-zoom);
  }

  pushMatrix();
  rotateX(radians(-400));

  pushMatrix();
  translate(width/2,height/2);
  scale(map(zoom,0,height,0.2,0.002));

  rotateY(radians(rotX));  
  pushMatrix(); 

  centView();
  translate(CPOINT[0],CPOINT[1],CPOINT[2]);


  for(int i = 0; i<ps.length;i++){
    int next = constrain(i-1,0,ps.length);
    //line(ps[i].x,ps[i].y,ps[i].z,ps[next].x,ps[next].y,ps[next].z);
    SX[i] = screenX(ps[i].x,ps[i].y,ps[i].z);
    SY[i] = screenY(ps[i].x,ps[i].y,ps[i].z);
    SZ[i] = screenZ(ps[i].x,ps[i].y,ps[i].z);

    ps[i].draw(255);//(int)map(SZ[i],0.94,0.92,120,250));
  }  

  for(int i = 0; i<snura.length;i++){
    snura[i].draw();  
  }  


  popMatrix();

  popMatrix();   

  popMatrix();

  fill(255,128,0,150);
  for(int i =0;i<SX.length;i++){

    text("<-----   "+i,SX[i]+20,SY[i]+5);
    noFill();
    stroke(255,128,0,150);
    ellipse(SX[i],SY[i],45,45);  
  }
}

// -----------------------------------------------------  >

void centView(){
  for(int i = 0;i<snura.length;i++){
     for(int q= 0;q<3;q++){
    CPOINT[0] += (-snura[i].particles[(int)constrain(snura[i].particles.length*q*0.5,0,snura[i].particles.length-1)].position().x()-CPOINT[0])*0.02;
    CPOINT[1] += (-snura[i].particles[(int)constrain(snura[i].particles.length*q*0.5,0,snura[i].particles.length-1)].position().y()-CPOINT[1])*0.02;
    CPOINT[2] += (-snura[i].particles[(int)constrain(snura[i].particles.length*q*0.5,0,snura[i].particles.length-1)].position().z()-CPOINT[2])*0.02;
     }
  }

}


// -----------------------------------------------------  >
void mousePressed(){
  if(selecting&&got){
    sel1=  which;
    dragging = true;
  }
  else if(mouseButton==RIGHT){
    writer.writeToFile("klenba.cloud");
  }  
}

// -----------------------------------------------------  >

void mouseReleased(){
  if(selecting&&got&&which!=sel1){
    sel2 = which;
    addLev(sel1,sel2);
    dragging = false;
  }  
}

// -----------------------------------------------------  >

void keyPressed(){
  if(keyCode==ENTER){
    reload();
  }else if(keyCode==DOWN){
    gravity+=1.0;
    physics.setGravity( gravity );
  }else if(keyCode==UP){
    gravity-=1.0;
    physics.setGravity( gravity ); 
  }
}

void loadIcon(String q){
  String path = sketchPath("data/"+q); 
  path.replace('\\','/');    
  Image img = getToolkit().getImage(path);
  frame.setIconImage(img);
}
void select(){
  // -----------------------------------------------------  >
  if(keyPressed&&key==' '){
    selecting = true;
  }
  else{
    selecting = false;
  }
  stroke(255);
  // -----------------------------------------------------  >
  if(selecting){
    got = false;
    for(int i = 0;i<snura.length;i++){
      snura[i].colSel = color(255);
      if(snura[i].over()&&!got){
        snura[i].colSel = color(255,0,0);
        got = true;
        which = i;
      }
    }
  }
}
