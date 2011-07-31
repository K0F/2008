
int num = 100;

float trsh = 40;

Point3 o[];
Writer w;
String[] lins;

void setup(){
	size(screen.width/2+10,screen.height/2+10,P3D);

	o = new Point3[num];
	w= new Writer(sketchPath,"test2.txt");
	//smb://192.168.0.10/04%20(c)/CurrentWorks/ExternalMapingGH/Data"

	//String[] q = loadStrings("smb:\\192.168.0.10\04%20(c)\CurrentWorks\ExternalMapingGH\Data\test.txt");
	//if(q.length>0)
	//println(q[0]);
	
	for(int i = 0;i<o.length;i++){
		o[i] = new Point3(i,(i*3)%width,random(height),0);
	}

	stroke(0,40);
	//smooth();
}

void draw(){
	background(255);

	
	pushMatrix();
	translate(0,0,-width);
	pushMatrix();
	
	translate(width/2.0,height/2.0,height/2.0);
	pushMatrix();
	rotateY(frameCount/180.0);
	translate(-width/2.0,-height/2.0,-height/2.0);



	for(int i = 0;i<num;i++){
		o[i].live();

		for(int r = 0;r<num;r++){
			if(i!=r){
				float dd = dist(o[i].x,o[i].y,o[i].z,o[r].x,o[r].y,o[r].z);
				if(dd<trsh){
					line(o[i].x,o[i].y,o[i].z,o[r].x,o[r].y,o[r].z);
				}

			}
			}

		}



		popMatrix();		
		popMatrix();


		popMatrix();



	}


	void keyPressed(){
		if(key=='s'){
			w.write();
		}else if(key == 'q'){
			exit();
		}else if(key == 'w'){
			save("rawMap_"+nf(frameCount,6)+".png");
		}

	}
