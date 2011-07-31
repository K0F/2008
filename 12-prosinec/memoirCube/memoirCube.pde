// -----------------------  >

//import processing.opengl.*;
import gifAnimation.*;

Gif anim;
PImage[] allFrames;
int num;
int cnt = 0;
boolean automate = false;
///////////////////////////////////////

boolean rec = true;
///////////////////////////////////////
int kadence = 2;
boolean newfr = true;
//////////////////////////////////////

PImage img,tmp;

Recorder r;

//-----------------------  >

void setup(){
	size(200,201);

	allFrames  = Gif.getPImages(this,"metaCubeMemoir.gif");
	num = allFrames.length;
	smooth();
	//println(allFrames.length);
	//anim.setDelay(10);
	//anim.play();

	//tmp = img;
	//tmp.filter(INVERT);
	//img.mask(tmp);
	if(rec)
	r = new Recorder("out","cube.avi");
}

//-----------------------  >

void draw(){
	fill(255,155);
	rect(1,0,width-2,height-2);
//	filter(BLUR,4);
if(automate){
	if(frameCount%kadence==0)
		newfr = true;
	cnt++;
}
	image(allFrames[cnt%allFrames.length],0,0,width,height);

	newfr = false;
	
	if(rec)
	r.add();
}

void keyPressed(){
	if(key=='q'){
		if(rec)
			r.finish();
		exit();
	}else if(key == ' '){
		rec=!rec;
	}else if(key == 'a'){
		automate=!automate;
	}else if(key == 's'){
		cnt++;
	}

}





