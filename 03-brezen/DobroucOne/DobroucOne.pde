String points[];
String spoints[] = new String[0];

float x[] = new float[0];
float y[] = new float[0];
float z[] = new float[0];

float xmin,xmax,ymin,ymax,zmin,zmax;
float centX,centY,centZ;

int pocet;
float theta;
float rotX;
float rotY;
boolean loaded = false;
void setup()
{
	size(800, 600, P3D);
	frameRate(30);

	noFill();

	loadPoints();
	getMinMax();
}

void draw(){
	background(0);
	stroke(255,75);
	pushMatrix();
	translate(width/2,height/2+30,0);
	frame.setTitle("processing hack");
	pushMatrix();
	theta+=0.01;
	rotateY(theta);
	beginShape(POLYGON);
	for(int i = 0;i<pocet;i++){
		float q = dist(gX(x[i]),gX(y[i]),gX(z[i])-150,mouseX,mouseY,-150);
		vertex(gX(x[i]),gX(y[i]),50*(sin(q/100.0f)+1)+gX(z[i])-150);

		/*pushMatrix();
		translate(gX(x[i]),gX(y[i]),gX(z[i]));
		point(0,0,0);

		popMatrix(); */
	}
	endShape();
	popMatrix();
	popMatrix();

}



