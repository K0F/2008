
int num = 10;
int vorSides = 5;
float x[],y[];
float kolmit[][][] = new float[num][vorSides][4];
float cx[],cy[];

PVector p[] = new PVector[0];

void setup(){
	size(400,400,P3D);

	rerand();

	rectMode(CENTER);
	stroke(0);
	noStroke();
	fill(0);

}

void draw(){
	background(255);

	for(int i =0;i<num;i++){
		rect(x[i],y[i],4,4);
	}

	for(int i =0;i<num;i++){
		for(int q =0;q<vorSides;q++){
			kolmit[i][q] = kolmice(x[i],y[i],x[closest(i,vorSides)[q]],y[closest(i,vorSides)[q]]);
		}
	}

	//println(kolmit[frameCount%num][1][0]);
	cx = new float[0];
	cy = new float[0];

	for(int i =0;i<num;i++){
		for(int a = 0;a<vorSides;a++){
			for(int b = 0;b<vorSides;b++){
				if(a!=b){
					PVector inter= lineIntersection(kolmit[i][a][0],kolmit[i][a][1],kolmit[i][a][2],kolmit[i][a][3],kolmit[i][b][0],kolmit[i][b][1],kolmit[i][b][2],kolmit[i][b][3]);

					stroke(0,155);
					noFill();

					/*
							line(kolmit[i][0][0],kolmit[i][0][1],kolmit[i][0][2],kolmit[i][0][3]);
							line(kolmit[i][1][0],kolmit[i][1][1],kolmit[i][1][2],kolmit[i][1][3]);
							line(kolmit[i][2][0],kolmit[i][2][1],kolmit[i][2][2],kolmit[i][2][3]);
					*/		
					//println(inter.x+" || "+inter.y);

					if(inter!=null){
						cx = (float[])expand(cx,cx.length+1);
						cy = (float[])expand(cy,cy.length+1);
						cx[cx.length-1] = inter.x;
						cy[cy.length-1] = inter.y;
					}
				}
			}
		}
	}

	int kol = 15;
	//serf bodama
	for(int q =0;q<num;q++){
		//x nejblizsich pruseciku
		int neig[] = closestCX(q,kol);
		beginShape();
		for(int i =0;i<kol;i++){
			int nei = closestC(neig[i],1)[0];
			vertex(cx[neig[i]],cy[neig[i]]);
			vertex(cx[nei],cy[nei]);
		}
		endShape();
	}
}

void keyPressed(){
	println(kolmit[0][1][0]+" : "+kolmit[0][1][1]+" : "+kolmit[0][1][2]+" : "+kolmit[0][1][3]);
}

void mousePressed(){
	if(mouseButton==LEFT){
		rerand();
	}
}

void rerand(){
	x =  new float[num];
	y = new float[num];

	for(int i =0;i<num;i++){
		x[i] = random(width);
		y[i] = random(height);
	}
}

float[] kolmice(float x1,float y1,float x2,float y2){
	float A1 = x1-x2;
	float A2 = y1-y2;
	float midX = lerp(x1,x2,0.5);
	float midY = lerp(y1,y2,0.5);
	float resX = midX+A2*0.5;
	float resY = midY-A1*0.5;
	float resX2 = midX-A2*0.5;
	float resY2 = midY+A1*0.5;

	float[] res = {resX,resY,resX2,resY2};
	return res;
}

boolean isNeighs(int a,int b){
	boolean answ = false;
	for(int i =0;i<vorSides;i++){
		if(closest(a,vorSides)[i]==b){
			answ = true;
		}
	}
	return answ;
}

int[] closest(int q,int _kolik){
	int[] answr = new int[_kolik];
	float[] temp = new float[num];
	float[] temp2 = new float[num];

	for(int i =0 ;i<num;i++){
		if(i==q){
			temp[i]=width;
		}else{
		temp[i] = dist(x[i],y[i],x[q],y[q]);
		}
	}

	temp2=temp;

	for(int i =0;i<_kolik;i++){
		for(int w =0;w<num;w++){
			if(temp[w]==min(temp)){
				answr[i] = w;
				temp[w] = max(temp);
				break;
			}
		}
	}

	return answr;
}

int[] closestC(int q,int _kolik){
	int[] answr = new int[_kolik];
	float[] temp = new float[cx.length];
	float[] temp2 = new float[cx.length];

	for(int i =0 ;i<cx.length;i++){
		if(i==q){
			temp[i]=width;
		}else{
		temp[i] = dist(cx[i],cy[i],cx[q],cy[q]);
		}
	}

	temp2=temp;

	for(int i =0;i<_kolik;i++){
		for(int w =0;w<cx.length;w++){
			if(temp[w]==min(temp)){
				answr[i] = w;
				temp[w] = max(temp);
				break;
			}
		}
	}
	return answr;
}


int[] closestCX(int q,int _kolik){
	int[] answr = new int[_kolik];
	float[] temp = new float[cx.length];
	float[] temp2 = new float[cx.length];

	for(int i =0 ;i<cx.length;i++){
		if(i==q){
			temp[i]=width;
		}else{
		temp[i] = dist(x[q],y[q],cx[i],cy[i]);
		}
	}

	temp2=temp;

	for(int i =0;i<_kolik;i++){
		for(int w =0;w<cx.length;w++){
			if(temp[w]==min(temp)){
				answr[i] = w;
				temp[w] = max(temp);
				break;
			}
		}
	}

	return answr;
}

PVector segIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
	float bx = x2 - x1;
	float by = y2 - y1;
	float dx = x4 - x3;
	float dy = y4 - y3;

	float b_dot_d_perp = bx * dy - by * dx;

	if(b_dot_d_perp == 0) return null;

	float cx = x3 - x1;
	float cy = y3 - y1;

	float t = (cx * dy - cy * dx) / b_dot_d_perp;
	if(t < 0 || t > 1) return null;

	float u = (cx * by - cy * bx) / b_dot_d_perp;
	if(u < 0 || u > 1) return null;

	return new PVector(x1+t*bx, y1+t*by);
}

PVector lineIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
	float bx = x2 - x1;
	float by = y2 - y1;
	float dx = x4 - x3;
	float dy = y4 - y3;

	float b_dot_d_perp = bx*dy - by*dx;

	if(b_dot_d_perp == 0) return null;

	float cx = x3-x1;
	float cy = y3-y1;

	float t = (cx*dy - cy*dx) / b_dot_d_perp;

	return new PVector(x1+t*bx, y1+t*by);
}
