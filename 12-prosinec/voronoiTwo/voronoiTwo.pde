
//import com.processinghacks.triangulate.*;


int num = 16;
float baseX[],baseY[];
Triangle t[];
float centersX[],centersY[];


void setup(){
	size(400,400);


	reseed();

	textFont(createFont("Veranda",9));
	fill(0,155);
	stroke(0,155);
	rectMode(CENTER);
	smooth();
}

void reseed(){
	baseX = new float[num];
	baseY = new float[num];

	for(int i =0;i<num;i++){
		baseX[i] = random(width);
		baseY[i] = random(height);
	}
	t = new Triangle[num];
	centersX = new float[num];
	centersY = new float[num];

	int old = -2;
	for(int i =0;i<t.length;i++){
		t[i] = new Triangle(i);
		old++;
	}
}

void mousePressed(){
	if(mouseButton==LEFT){
		reseed();
	}

}

void draw(){
	background(255);

	for(int i = 0;i<num;i++){
		noStroke();
		stroke(0,155);
		rect(baseX[i],baseY[i],3,3);
		
		//text(i,baseX[i]+5,baseY[i]);
	}

	for(int i =0;i<t.length;i++){
		stroke(#553300,155);
		t[i].compute();
		centersX[i] = t[i].X;
		centersY[i] = t[i].Y;
		text(i,centersX[i],centersY[i]);
		
	}
	

	int kolik = 5;
	noFill();
	for(int i =0;i<num;i++){
		int nei[] = closestCenters(i,kolik);
		beginShape();
		for(int q = 0;q<kolik;q++){
			vertex(centersX[nei[q]],centersY[nei[q]]);
		}
		endShape(CLOSE);

	}
}

void keyPressed(){
	if(key==' '){
		println(closestCenters(1,3));
	}
}


int[] closestCenters(int q,int _kolik){
	int[] answr = new int[_kolik];
	float[] temp = new float[centersX.length];
	//float[] temp2 = new float[num];

	for(int i =0 ;i<centersX.length;i++){
		
			temp[i] = dist(baseX[q],baseY[q],centersX[i],centersY[i]);
		
	}

	//temp2=temp;

	for(int i =0;i<_kolik;i++){
		for(int w =0;w<centersX.length;w++){
			if(temp[w]==min(temp)){
				answr[i] = w;
				temp[w] = max(temp);
				break;
			}
		}
	}

	return answr;
}






class Triangle{
	float x[],y[];
	float k[][];
	int base;
	int neighs[] = new int[2];
	float X,Y;
	boolean vizKolmice = true;
	boolean vizTriangle = true;
	boolean vizStred = true;
	PVector stred;

	Triangle(int _base){
		base = _base;
		x= new float[3];
		y= new float[3];
		x[0] = baseX[base];
		y[0] = baseY[base];

		k = new float[3][4];

	}

	void compute(){
		neighs = closest(base,4);
		x[1] = baseX[neighs[2]];
		y[1] = baseY[neighs[2]];
		x[2] = baseX[neighs[3]];
		y[2] = baseY[neighs[3]];

		k[0] = kolmice(x[0],y[0],x[1],y[1]);
		k[1] = kolmice(x[0],y[0],x[2],y[2]);
		//k[2] = kolmice(x[1],y[1],x[2],y[2]);


		stred = lineIntersection(k[0][0],k[0][1],k[0][2],k[0][3],k[1][0],k[1][1],k[1][2],k[1][3]);
		X = stred.x;
		Y = stred.y;

		draw();

	}

	void draw(){

		if(vizKolmice){
			line(k[0][0],k[0][1],k[0][2],k[0][3]);
			line(k[1][0],k[1][1],k[1][2],k[1][3]);
			line(k[2][0],k[2][1],k[2][2],k[2][3]);
		}
		if(vizStred){
			noFill();
			rect(X,Y,4,4);
			ellipse(X,Y,dist(x[0],y[0],X,Y)*2.0,dist(x[0],y[0],X,Y)*2.0);
		}
		if(vizTriangle)
			triangle(x[0],y[0],x[1],y[1],x[2],y[2]);
	}


	int[] closest(int q,int _kolik){
		int[] answr = new int[_kolik];
		float[] temp = new float[num];
		//float[] temp2 = new float[num];

		for(int i =0 ;i<num;i++){
			if(i==q){
				temp[i] = width*height;
			}else{
				temp[i] = dist(baseX[i],baseY[i],baseX[q],baseY[q]);
			}
		}

		//temp2=temp;

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

}
