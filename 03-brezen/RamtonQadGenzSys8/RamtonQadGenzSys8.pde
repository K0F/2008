int num = 5;
Node node[];

int op = 40;

PImage shade,high;

void setup(){
	size(7*op,6*op);
	background(0);
	node = new Node[num];
	frame.setTitle("QadGenz 8");
	for(int i = 0;i < node.length;i++){
		node[i] = new Node();
	}
	smooth();
	shade = loadImage("shade.png");
        high = loadImage("high.png");
	//smooth();
        frame.setLocation(0,screen.height-height); //works 

}

void draw(){
  float w = node[0].w;
	background(#5a6a7a);
	for(int i = 0;i < node.length;i++){
                int which = constrain(i-1,0,node.length);
                fill(255,85);
                triangle(node[i].x,node[i].y,node[i].x+3*w,node[i].y,
                (node[which].x+(1.5*w)),(node[which].y+(1.5*w)));
                
                triangle(node[i].x,node[i].y,node[i].x,node[i].y+3*w,
                (node[which].x+(1.5*w)),(node[which].y+(1.5*w)));
                
                triangle(node[i].x,node[i].y+3*w,node[i].x+3*w,node[i].y+3*w,
                (node[which].x+(1.5*w)),(node[which].y+(1.5*w)));
                
                triangle(node[i].x+3*w,node[i].y,node[i].x+3*w,node[i].y+3*w,
                (node[which].x+(1.5*w)),(node[which].y+(1.5*w)));
                
		node[i].run();
	}
}
