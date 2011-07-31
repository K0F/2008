import megamu.mesh.*;

int num = 500;

float thick = 0.15;
float sp = 1.31;


boolean mesh=false;
boolean voron=true;

Voronoi voronoi;
Site[] s;
float[][] points = new float[num][2];
float[][] myEdges;

/*
float xx[],yy[];
float tx[],ty[];
float lx[],ly[];
int cnt[];
*/

MPolygon[] regions;

void setup(){
	size(1200,800,P3D);
	frameRate(5);
//	smooth();	
	/*
	xx= new float[num];
	yy= new float[num];
		
	tx= new float[num];
	ty= new float[num];
	lx= new float[num];
	ly= new float[num];

	cnt = new int[num];
	*/
	
	reset();
}

void draw(){
background(0);

	//refresh();
	//update = false;

	if(voron){
		for(int i=0; i<regions.length; i++){
			// an array of points
			float[][] rc = regions[i].getCoords();

			noStroke();
			//fill(255,90);

			//beginShape();
			
			//for(int q =0;q<rc.length;q++){
				//for(int o =0;o<rc.length;o++){
				
			/*	
				if(dist(xx[i],yy[i],tx[i],ty[i])<1.0){
					cnt[i]++;
					cnt[i] = cnt[i]%(rc.length-1);
				}
				cnt[i] = constrain(cnt[i],0,rc.length-1);
				
				try{
				tx[i] = lerp(rc[cnt[i]][0],s[i].x,thick);
				ty[i] = lerp(rc[cnt[i]][1],s[i].y,thick);
				xx[i] += (tx[i]-xx[i])/sp;
				yy[i] += (ty[i]-yy[i])/sp;
				
				
				line(xx[i],yy[i],lx[i],ly[i]);
				
				lx[i] = tx[i];
				ly[i] = ty[i];
				
				}catch( ArrayIndexOutOfBoundsException e){
					println("pruser2!!!"+e);
				}
				
				*/
				beginShape();
				
				for(int q =0;q<rc.length;q++){
				stroke(s[i].c);
					fill(s[i].c);
				vertex(lerp(rc[q][0],s[i].x,thick),lerp(rc[q][1],s[i].y,thick));
				
				}
				endShape(CLOSE);
				//
				//}

			//}
			//endShape(CLOSE);
		}
	}



	if(mesh){
		if(!voron){
			stroke(255,155);
		}else{
			stroke(0,155);
		}

		for(int i=0; i<myEdges.length; i++)
		{
			float startX = myEdges[i][0];
			float startY = myEdges[i][1];
			float endX = myEdges[i][2];
			float endY = myEdges[i][3];
			line( startX, startY, endX, endY );
		}
	}

	for(int i =0;i<num;i++){
		s[i].live();
	}

}

void reset(){
	s = new Site[num];
	//smooth();
	
	float X = 0;
	float Y = 0;
	for(int i =0;i<num;i++){
		s[i] = new Site(i,X,Y);
		
		X+=random(20,30);
		if(X>width){
		X=0;
		Y+=20;
		}
		
		
		points[i][0] = s[i].x;
		points[i][1] = s[i].y;
		/*
		lx[i]=tx[i]=xx[i] = s[i].x;
		ly[i]=ty[i]=yy[i] = s[i].y;
		cnt[i] = 0;
		*/
	}

	voronoi = new Voronoi( points );
	regions = voronoi.getRegions();
}

void refresh(){

	try{
		if(voron){
			voronoi = new Voronoi( points );
			regions = voronoi.getRegions();
		}

		if(mesh){
			Delaunay myDelaunay = new Delaunay( points );
			myEdges = myDelaunay.getEdges();
		}
	}catch( ArrayIndexOutOfBoundsException e){
		println("pruser!!! "+e);
		reset();
	}

}

void keyPressed(){
	if(key==' '){
		loop();
	}

}

class Site{
	float x,y;
	float tx,ty;
	int id = 0;
	int cyc = 4;
	color c;

	float brdr = 50.0;


	float speed = 120.0;
	float trsh = 20.0;

	Site(int _id){
		id=_id;
		tx = x = random(brdr,width-brdr);
		ty = y = random(brdr,height-brdr);
		c = color(random(120,255));
		//	speed = random(50,125);
	}

	Site(int _id,float _x,float _y){
		c = color(random(120,255));
		id=_id;
		tx = x = _x;
		ty = y = _y;
	}

	void live(){

		//move();
		//bordr(brdr);

		points[id][0] = x;
		points[id][1] = y;

		draw();
	}

	void move(){
		for(int i =0;i<s.length;i++){
			if(i!=id){
				float d = dist(s[i].x,s[i].y,x,y);
				d = constrain(d,1.001,width);

				//c = lerpColor(#FFFFFF,#FFCC00,map(d,trsh*2,0,0,1));
				tx+=(s[i].x-tx)/(d*4.0);
				ty+=(s[i].y-ty)/(d*4.0);

				if(d<trsh){
					tx-=(s[i].x-tx)/(d);
					ty-=(s[i].y-ty)/(d);
				}

			}

		}

		//	tx = constrain(tx,x-10,x+10);
		//		ty = constrain(ty,y-10,y+10);

		x+=(tx-x)/speed;
		y+=(ty-y)/speed;

	}

	void bordr(float k){
		x = constrain(x,k,width-k);
		y = constrain(y,k,height-k);

	}

	void draw(){
		fill(0,150);
		noStroke();
		rect(x-1.5,y-1.5,2,2);
	}


}

/*
	myVoronoi = new Voronoi( points );
	
	float[][] myEdges = myVoronoi.getEdges();

for(int i=0; i<myEdges.length; i++)
{
	float startX = myEdges[i][0];
	float startY = myEdges[i][1];
	float endX = myEdges[i][2];
	float endY = myEdges[i][3];
	line( startX, startY, endX, endY );
}

	myRegions = myVoronoi.getRegions();

	for(int i=0; i<myRegions.length; i++){
		// an array of points
		float[][] regionCoordinates = myRegions[i].getCoords();

		fill(255,0,0,50);
		myRegions[i].draw(this); // draw this shape
	}
*/


