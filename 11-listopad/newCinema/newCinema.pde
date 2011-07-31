import oscP5.*;

boolean rec = true;
color c;
Recorder r;
char a = ' ';
int next = 25;
int spell = 0;
String string = "";
int num = 7;

void setup(){
	size(720,576,P3D);
	background(255);
	textFont(createFont("anorexia",92));
	fill(0);
	textMode(SCREEN);
	textAlign(CENTER);
	
	c = color(255);

        for(int i = 0 ;i<num;i++)
        string+=""+(char)random(65,122);
        
	if(rec)
	r= new Recorder("out","dva.avi");
}


void draw(){
	
	if(frameCount%10==0){
		//a = (char)random(65,122);
                a=string.charAt(spell);
                spell++;
                if(spell>string.length()-1){
                spell=0;
                string+=""+(char)random(65,122);
                }
	}
	
	
	//background(c);
        fill(255,40);
        noStroke();
        rect(0,0,width,height);
        fill(0);
        filter(BLUR,2);
        
	text(a+"",width/2,height/2);
	
	if(rec)
	r.add();

}

void keyPressed(){
	if(key=='q'&&rec){
		r.finish();
		exit();
	}else if(key=='q'){
		exit();
	}

}
