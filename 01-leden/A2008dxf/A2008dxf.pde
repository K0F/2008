import processing.dxf.*;
//////////////////////////////
//MovieMaker mm;
int n = 200;
AGroup[] ag = new AGroup[n];

boolean record;

void setup(){
  size(400,400,P3D);
  background(255);  
  for(int i = 0;i<n;i++){
   ag[i] = new AGroup(i,(int)random(4,180));
  } 
 // mm = new MovieMaker(this, width, height, "out/rotoshapenBatch3.mov",25, MovieMaker.JPEG, MovieMaker.HIGH);
  //noSmooth();
}

void mousePressed(){
  for(int i = 0;i<n;i++){
   ag[i].reset();
  }
 mousePressed=false; 
}
void draw(){
  background(255);
  if (record) {
    beginRaw(DXF, "dxf/output.dxf");
  }
   for(int i = 0;i<n;i++){
   ag[i].run();
  }
  if (record) {
    endRaw();
    record = false;
  }
  // mm.addFrame();
}

void keyPressed(){
	if(key==' '){
		save("screen.png");
	} else if(keyCode==ENTER){
		//mm.finish();
		println("hotovo!");
	}else if (key == 'r'){ record = true;
        }
	keyPressed=false;
}


