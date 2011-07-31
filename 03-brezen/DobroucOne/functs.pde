void mouseDragged()
{
	rotX += (mouseX - pmouseX) * 0.01;
	rotY -= (mouseY - pmouseY) * 0.01;
}

void loadPoints(){
	points = loadStrings("plocha.obj");
	int gi = 0;
	for(int i = 0;i<points.length;i++){
		if(points[i].length()>0){
			if(points[i].charAt(0)=='v'&&points[i].charAt(1)==' '){
				spoints = (String[])expand(spoints,spoints.length+1);
				spoints[gi] = points[i]+"";
				x=(float[])expand(x,x.length+1);
				y=(float[])expand(y,y.length+1);
				z=(float[])expand(z,z.length+1);
				String[] tmp = splitTokens(spoints[gi]," ");
				x[gi] = parseFloat(tmp[1]);
				y[gi] = parseFloat(tmp[2]);
				z[gi] = parseFloat(tmp[3]);
				//println(x[gi]);
				gi++;
			}
		}
	}
	pocet = gi;
	println(gi+" points stored");
}

void getMinMax(){
	xmin = min(x);
	xmax = max(x);
	ymin = min(y);
	ymax = max(y);
	zmin = min(z);
	zmax = max(z);

	centX = (xmin+xmax)/2.0f;
	centY = (ymin+ymax)/2.0f;
	centZ = (zmin+zmax)/2.0f;
}

float gX(float _x){
	return (map(_x,xmin,xmax,-100,100));
}
float gY(float _x){
	return (map(_x,ymin,xmax,-width/3,width/3));
}
float gZ(float _x){
	return (map(_x,ymin,xmax,-width/3,width/3));
}
