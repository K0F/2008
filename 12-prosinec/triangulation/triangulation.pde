/**
triangulation taken from http://processinghacks.com/hacks:triangulation
@author Tom Carden
*/

import com.processinghacks.triangulate.*;

int num = 10;
int sousede = 2;
float x[],y[];

Vector triangles = new Vector();
Vector points = new Vector();

void setup() {

	size(400,400);
	smooth();
	noLoop();
	rectMode(CENTER);
	
	x = new float[num];
	y = new float[num];
	
	for(int i =0;i<num;i++){
		x[i] = random(width);
		y[i] = random(height);
		points.addElement( new Point3f(x[i],y[i],0) );
	}

	// get the triangulated mesh
	triangles = Triangulate.triangulate(points);

}


void draw() {

	background(200);

	// draw points as red dots
	stroke(#FFCC00);
	fill(255,0,0);
	for (int i = 0; i < num; i++) {
		Point3f p = (Point3f)points.elementAt(i);
		ellipse(p.x,p.y,2.5,2.5);
	}

	// draw the mesh of triangles
	stroke(0,40);
	fill(255,40);
	beginShape();
	for (int i = 0; i < triangles.size(); i++) {
		Triangle t = (Triangle)triangles.elementAt(i);
		float [] k1 = kolmice(t.p1.x,t.p1.y,t.p2.x,t.p2.y);
		float [] k2 = kolmice(t.p3.x,t.p3.y,t.p2.x,t.p2.y);
		Point3f temp = lineIntersection(k1[0],k1[1],k1[2],k1[3],k2[0],k2[1],k2[2],k2[3]);
		line(k1[0],k1[1],k1[2],k1[3]);
		line(k2[0],k2[1],k2[2],k2[3]);
		
		rect(temp.x,temp.y,5,5);
		
		vertex(t.p1.x,t.p1.y);
		vertex(t.p2.x,t.p2.y);
		vertex(t.p3.x,t.p3.y);
	}
	endShape(CLOSE);

}

 Point3f lineIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
		float bx = x2 - x1;
		float by = y2 - y1;
		float dx = x4 - x3;
		float dy = y4 - y3;

		float b_dot_d_perp = bx*dy - by*dx;

		if(b_dot_d_perp == 0) return null;

		float cx = x3-x1;
		float cy = y3-y1;

		float t = (cx*dy - cy*dx) / b_dot_d_perp;

		return new  Point3f(x1+t*bx, y1+t*by,0);
	}

int[] closest(int q,int _kolik){
		int[] answr = new int[_kolik];
		float[] temp = new float[num];
		//float[] temp2 = new float[num];

		for(int i =0 ;i<num;i++){
			if(i==q){
				temp[i] = width*height;
			}else{
				temp[i] = dist(x[i],y[i],x[q],y[q]);
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


