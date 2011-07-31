
boolean[][] stamp;

void setup(){
	size(200,200);
	background(0);
	noStroke();
	smooth();
	
	frame.setTitle("hackitectura 02 pre");

	stamp = new boolean[width][height];
	for(int x = 5;x<width-5;x+=10){
		for(int y = 5;y<height-5;y+=10){
			stamp[x][y]=false;
		}
	}
} 

void draw(){
	//background(0);

	for(int x = 5;x<width-5;x+=10){
		if(random(5)<1){
			for(int y = 5;y<height-5;y+=10){

				if(random(5)<1){

					if(stamp[x][y]){
						stamp[x][y]=false;
						fill(0,128);
					}else{
						fill(255,128,0,128);
						stamp[x][y]=true;
					}
					rect(x,y,8,8);

				}
			}
		}
	}
}
