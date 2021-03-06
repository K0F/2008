

class GpsViz{
	PApplet rodic;
	Serial in;
	String raw = "";
	float lat = 0;
	float lon = 0;
	float alt = 0;
	int time = 0;
	int h,m,s;
	int satelites = 0;
	String N = "";
	String W = "";
	float rozsahN,rozsahW,pomer;

	float xmin,ymin;
	float xmax,ymax;

	float X[],Y[],Xs[],Ys[];
	int ex[];
	
	////  ///////////////// >
	GpsViz(PApplet _rodic,int _com,int _baud){
		rodic=_rodic;
		println(Serial.list());
		in = new Serial(rodic,Serial.list()[_com], _baud); //com9

		in.clear(); //prvni smycka
		raw = in.readStringUntil(10);
		raw = null;

		resetVars();

	}
	
	////  ///////////////// >
	void resetVars(){
		xmin = ymin = 100000;
		xmax = ymax =-1;
		ex = new int[0];
		X = new float[0];
		Y = new float[0];
		Xs = new float[0];
		Ys = new float[0];
	}
	
	////  ///////////////// >
	void run(){
		getRaw();
		drawGraph();
		drawLegend(0,20);
	}
	
	////  ///////////////// >
	void getRaw(){
		while (in.available() > 1) {
			raw = in.readStringUntil(10);
			if(raw!=null){
				String _tmp = raw+"";
				_tmp+=" XXXXXX"; //zz
				//println(_tmp);
				if(_tmp.substring(0,6).equals("$GPGGA")){
					parseGPGGA(raw,false);
				}// end if $GPGGA
			}// end if null
		}// end while
	}
	
	////  ///////////////// >
	void parseGPGGA(String _raw,boolean debug){
		String temp[] = splitTokens(_raw,",");
		writeVars(temp);
		if(debug){
			println("time: "+
			        temp[1].substring(0,2)+":"+
			        temp[1].substring(2,4)+"."+
			        temp[1].substring(4,6)+"s");
			println("lat: "+temp[2]+" "+temp[3]);
			println("lon: "+temp[4]+" "+temp[5]);
			println("no of satelites in use: "+temp[7]);
		}
	}
	
	////  ///////////////// >
	void writeVars(String data[]){
		/*1    = UTC of Position
		 2    = Latitude
		 3    = N or S
		 4    = Longitude
		 5    = E or W
		 6    = GPS quality indicator (0=invalid; 1=GPS fix; 2=Diff. GPS fix)
		 7    = Number of satellites in use [not those in view]
		 8    = Horizontal dilution of position
		 9    = Antenna altitude above/below mean sea level (geoid)
		 10   = Meters  (Antenna height unit)
		 11   = Geoidal separation (Diff. between WGS-84 earth ellipsoid and
		 mean sea level.  -=geoid is below WGS-84 ellipsoid)
		 12   = Meters  (Units of geoidal separation)
		 13   = Age in seconds since last update from diff. reference station
		 14   = Diff. reference station ID#
		 15   = Checksum
		 */

		time = parseInt(data[1]);
		h = parseInt(data[1].substring(0,2));
		m = parseInt(data[1].substring(2,4));
		s = parseInt(data[1].substring(4,6));
		N = data[3]+"";
		W = data[5]+"";
		lat = parseFloat(data[2]);
		lon = parseFloat(data[4]);
		alt = parseFloat(data[6]);
		if(data[7]!=null){
			satelites = parseInt(data[7]);
		}
		else{
			satelites = 0;
		}
		updateGraph(true);
	}
	
	////  ///////////////// >
	void updateGraph(boolean debug){
		//// exp ///////////////// >
		int nova = X.length+1;
		X=(float[])expand(X,nova);
		Y=(float[])expand(Y,nova);
		Xs=(float[])expand(Xs,nova);
		Ys=(float[])expand(Ys,nova);
		ex=(int[])expand(ex,nova);
		// alt=(float[])expand(Ys,nova);

		//// set ///////////////// >
		int aktualni = X.length-1;
		X[aktualni] = lon;
		Y[aktualni] = lat;

		ex[aktualni] = satelites;

		//// min max ///////////////// >
		if(xmin>lon)xmin = lon;
		if(xmax<lon)xmax = lon;
		if(ymin>lat)ymin = lat;
		if(ymax<lat)ymax = lat;

		rozsahN = abs(ymin-ymax);
		rozsahW = abs(xmin-xmax);
		//rozsahN = norm(rozsahN,0, );

		pomer = 1f;
		if(rozsahW>0f){
			pomer = rozsahN/rozsahW;
		}
		if(debug)println("ratio: "+pomer);
		
		//// mapo ///////////////// >
		for(int i = 0;i<X.length;i++){
			Xs[i] = map(X[i],xmax,xmin,5,width-5);
			Ys[i] = map(Y[i],ymax,ymin,5,height-5);
		}
		//println(debug?X.length+"":"");
	}
	
	////  ///////////////// >
	void drawGraph(){
		pushMatrix();
		//scale(pomer,pomer); //opt
		beginShape(LINES);
		for(int i = 1;i<X.length;i++){
			stroke(lerpColor(#FFCC00,#FFFFFF,norm(ex[i],0,8)),155);
			line(Xs[i],Ys[i],Xs[i-1],Ys[i-1]);
		}
		endShape();
		popMatrix();
	}
	
	////  ///////////////// >
	void drawLegend(float x,float y){
		pushMatrix();
		translate(x,y);
		text("UTC: "+((h<10)?"0":"")+h+":"+
		     ((m<10)?"0":"")+m+
		     "  "+((s<10)?"0":"")+s+"sec",10,10);

		text("latitude: "+lat+" "+N,10,20);
		text("longitude: "+lon+" "+W,10,30);
		text("no of satelites: "+satelites,10,40);
		popMatrix();
	}



}
