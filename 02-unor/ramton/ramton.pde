import processing.opengl.*;

int num = 20;
Node node[];

PImage shade,high;

void setup(){
	size(200,200);
	background(0);
	node = new Node[num];
	frame.setTitle("<< d.b >>");
	for(int i = 0;i < node.length;i++){
		node[i] = new Node();
	}
	
	shade = loadImage("shade.png");
        high = loadImage("high.png");
	//smooth();
        frame.setLocation(0,screen.height-height); //works 

}
int i = 0;

void draw(){
	background(#000000);
	for(int i = 0;i < node.length;i++){
		node[i].run();
	}
i++;
if(i>screen.width){i=-width;}
	frame.setLocation(i,screen.height-height); //works 
	/*
	if(frameCount%30==0){
		for(int i = 0;i < node.length;i++){
			node[i].reset();
		}
	}*/
}

void mousePressed(){
	for(int i = 0;i < node.length;i++){
		if(node[i].over()){
			node[i].reset();
		}
	}
}

public void init(){
 frame.setUndecorated(true);
 super.init(); 
  
  
}



