//////////////////////////////////////////////////////////////////////////////////

class Director{
	float theta;
	float x1,y1,x2,y2;
	float speed = 10.0;
	int q1,q2;

	//////////////////////////////////////////////////////////////////////////////////
	Director(){
		x1=x2=getX();
		y1=y2=getY();
		q1=q2=0;
	}
	//////////////////////////////////////////////////////////////////////////////////

	void draw(float x,float y){
		pushMatrix();
		translate(x,y);
		rotate(theta);
		fill(0,155);
		stroke(255,0,0);
		ellipse(0,0,20,20);
		rect(20,-5,100,10);
		popMatrix();

		fill(200);

		pushMatrix();
		translate(x,y);

		q2 = banger(25);
		/*
		if(q2!=q1){
			if(cp.mute){
				println("d "+q2);
				player.send("/d"+q2,1);
			}
		}*/

		//////////////////////////////////////////////////////////////////////////////////


		q1 = banger(25);
		fill(255);
		stroke(0);
		switch(banger(25)){
		case 0:
			break;
		case 1:
			rect(-80,-80,10,10);
			break;
		case 2:
			rect(0,-80,10,10);
			break;
		case 3:
			rect(80,-80,10,10);
			break;
		case 4:
			rect(80,0,10,10);
			break;
		case 5:
			rect(80,80,10,10);
			break;
		case 6:
			rect(0,80,10,10);
			break;
		case 7:
			rect(0,-80,10,10);
			break;
		case 8:
			rect(-80,0,10,10);
			break;
		}

		popMatrix();

		fill(0);

		text((int)degrees(theta)+"`",(int)x+10,(int)y);

	}

	//////////////////////////////////////////////////////////////////////////////////

	void compute(){
		x2=getX();
		y2=getY();

		if((abs((y2-y1))>1)||(abs(x2-x1)>1)){
			theta += (atan2((y2-y1),(x2-x1))-theta)/ speed;

		}
		//println(degrees(theta));

		x1=getX();
		y1=getY();

		draw(x1,y1);

	}

	//////////////////////////////////////////////////////////////////////////////////

	float getX(){
		return player.avgX;
	}

	//////////////////////////////////////////////////////////////////////////////////

	float getY(){
		return player.avgY;
	}

	//////////////////////////////////////////////////////////////////////////////////

	int banger(int _tol){
		int dir = 0;
		int shift =  0;

		if(abs((-135+shift)-(int)degrees(theta))<_tol){
			dir = 1;
		}else if(abs((-90+shift)-(int)degrees(theta))<_tol){
			dir = 2;
		}else if(abs((-45+shift)-(int)degrees(theta))<_tol){
			dir = 3;
		}else if(abs((0+shift)-(int)degrees(theta))<_tol){
			dir = 4;
		}else if(abs((45+shift)-(int)degrees(theta))<_tol){
			dir = 5;
		}else if(abs((90+shift)-(int)degrees(theta))<_tol){
			dir = 6;
		}else if(abs((135+shift)-(int)degrees(theta))<_tol){
			dir = 7;
		}
		else if(abs((180+shift)-(int)degrees(theta))<_tol){
			dir = 8;
		}
		return dir;
	}
}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
