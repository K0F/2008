
PFont f; 

Node node;

void setup(){

	size(200,200);
	f = createFont("Arial",9);
	textFont(f);
	frame.setResizable(true);
	frame.setTitle("alive!");
	
	fill(255);
	stroke(255,45);
	node = new Node(0);
	smooth();
}


void draw(){
	background(0);
	fill(255);
	textFont(f);
	text("width "+ width+"\n"+"height "+height,10,10);
	
	node.run();
}

