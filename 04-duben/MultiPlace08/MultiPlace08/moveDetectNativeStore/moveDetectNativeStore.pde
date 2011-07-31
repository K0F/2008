import processing.video.*;

float treshold = 100;

int hold = 30;
int timer = 0;

OSC osc;
Capture in;
Senzor senzor;
int W=320,H=240;
int[] old;
int numPixels = W*H;
int cnt = 0;
int iNo = 1;


boolean clicked = false,viz = true,capturing = false;


PImage tmp;
PImage[] cyklon = new PImage[0];

void setup(){
	size(W,H,P3D);
	in = new Capture(this, W, H);

	senzor = new Senzor(10,10,50,50,treshold);

	noStroke();
	old = new int[numPixels];

	textFont(createFont("Arial",9));
	textMode(SCREEN );
	osc = new OSC("192.168.1.103",12010);

	tmp = createImage(1,1,RGB);

	loadPixels();
}


void draw(){
	if (in.available()) {
		in.read();
		in.loadPixels();
		cnt = 0;

		if(!viz){
			background(0);
		}

		for(int x = 0;x<W;x++){
			for(int y = 0;y<H;y++){

				int num = y*W+x;
				float movementSum;
				color currColor = in.pixels[num];
				color prevColor = old[num];

				int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
				int currG = (currColor >> 8) & 0xFF;
				int currB = currColor & 0xFF;

				int prevR = (prevColor >> 16) & 0xFF;
				int prevG = (prevColor >> 8) & 0xFF;
				int prevB = prevColor & 0xFF;

				int diffR = abs(currR - prevR);
				int diffG = abs(currG - prevG);
				int diffB = abs(currB - prevB);

				movementSum = (diffR + diffG + diffB)/3.0;

				old[num] = currColor;

				if(viz){
					pixels[num] = (currR << 16) | (currG << 8) | currB;
					updatePixels();
				}





				if(cnt==0)if(senzor.action(x,y,movementSum)){cnt++;}
			}
		}
	}



	if(timer>0){
		cnt=0;
		timer-=1;
	}

	if(clicked){
		senzor.w=mouseX-senzor.x;
		senzor.h=mouseY-senzor.y;

		fill(255,155);
		stroke(255);
		rect(senzor.x,senzor.y,senzor.w,senzor.h);
	}else if(cnt>0){
		capture();
 if(!capturing){
		senzor.draw(1);}
		osc.send(1.0);
                println("capture");
		timer = hold;
	}else{

		
                if(!capturing){
                image(tmp,senzor.x,senzor.y);
                fill(255);
	        text((int)treshold,senzor.x+senzor.w-25,senzor.y-2);
		senzor.draw(0);

		rect(senzor.x,senzor.y+senzor.h+2,map(timer,0,hold,0,senzor.w),5);
                }
	}

if(!viz){
   float X=0,Y=0;
 for(int i = 0;i<cyklon.length;i++){  
   
   
   if(X>width){
    X=0;Y+=cyklon[i].height;     
   }
  image(cyklon[i],X,Y);
  X+=(cyklon[i].width);
 } 
 if(Y>height)cyklon = new PImage[0];
  
}
	

	if(capturing){
		fill(#FFCC00);
		text("capture",3,10);
	}
}

void capture(){
	tmp = createImage(senzor.w,senzor.h,RGB);
	for(int x=senzor.x;x<senzor.x+senzor.w;x++){
		for(int y=senzor.y;y<senzor.y+senzor.h;y++){
			tmp.pixels[(y-senzor.y)*senzor.w+(x-senzor.x)] = in.pixels[y*W+x];
		}

	}
	if(capturing){
                cyklon = (PImage[])expand(cyklon,cyklon.length+1);
                cyklon[cyklon.length-1] = tmp;//createImage(tmp.width,tmp.height,RGB);
                                
		//tmp.save("out/capt"+iNo+".png");
		iNo++;
	}

}

void keyPressed(){
	if(keyCode==UP){
		treshold+=5;
	}else if(keyCode==DOWN){
		treshold-=5;
	} else if(key == ' '){
		viz=!viz;
	}else if (keyCode==LEFT){
		hold-=5;
	}else if(keyCode==RIGHT){
		hold+=5;
	}else if(keyCode == BACKSPACE){
		capturing=!capturing;
	}
	hold = constrain(hold,0,100000);

	senzor.tresh = treshold;
}

void mousePressed(){
	senzor.click(mouseX,mouseY);
	clicked =true;
}

void mouseReleased(){
	clicked = false;
	tmp = createImage(1,1,RGB);
	senzor.clickout(mouseX-senzor.x,mouseY-senzor.y);
}

class Senzor{
	int x,y,w,h;
	float tresh = 55.0;

	Senzor(int _x,int _y,int _w,int _h, float _tresh){
		tresh=_tresh;
		x=_x;
		y=_y;
		w=_w;
		h=_h;
	}

	void draw(int mode){

		if(mode==0){
			noFill();
			stroke(#FFCC00,255);
		}else{
			fill(#FFCC00,155);
			stroke(#FFCC00,255);
		}
		rect(x,y,w,h);
	}

	void click(int _x, int _y){
		x=_x;
		y=_y;
	}

	void clickout(int _w,int _h){
		w=_w;
		h=_h;
	}

	boolean action(int _x,int _y,float val){
		boolean answr = false;
		if(over(_x,_y)){
			answr = false;
		}
		else{
			if(val>tresh){
				answr = true;
			}
		}
		return answr;
	}

	boolean over(int _x,int _y){
		boolean a = false;
		if(_x<x||_y<y||_x>x+w||_y>y+h)a=true;
		return a;

	}
}

