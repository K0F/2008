import processing.opengl.*;
import processing.pdf.*;

boolean record;

int LEVEL = 0;
int ID = 0;
int cyc =1;
int c1=1,c2=1;
Euron e[] = new Euron[1];

void setup(){
	size(800,600);
	background(0);
	textFont(createFont("Veranda",9));
	textAlign(CENTER);
	stroke(0,100);

	e[0] = new Euron(3);                                                                                      
                                                                                                                   
	newGen(1,50);

}

void draw(){
	background(255);

	if (record) {
		// Note that #### will be replaced with the frame number. Fancy!
		beginRecord(PDF, "frame-####.pdf");
	}


	for(int i =0;i<e.length;i++)
		e[i].live();


	if (record) {
		endRecord();
		record = false;
	}

	//println("a");
}

void keyPressed(){
	if(key==' '){
		newGen(abs(c1-c2),70);

	}else if(keyCode==ENTER){
	record = true;	
	}

}

void newGen(int _kolik,int mut){
	c2=e.length;

	for(int q = 0;q<c2;q++){
		e[constrain(e.length-q,0,e.length-1)].born(mut);
		//println(q);
	}
	c1=e.length;

}
