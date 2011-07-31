
////////////////////////////////////////////////////////////////////////////////// Player Class

import JMyron.*;

//////////////////////////////////////////////////////////////////////////////////

class Player{
	JMyron m;
	
	//// OSC //////////////////////////////// >
	OscP5 oscMichal,oscMartin;
	NetAddress MichalAdd,MartinAdd;
	//// IP adresy //////////////////////////////// >
	String address1 = "192.168.22.95";
	String address2 = "192.168.22.101";
	
	// "192.168.0.2";
	//"127.0.0.1";
	//"78.102.53.186";
	
	//// porty //////////////////////////////// >
	
	int port = 6000;
	int port2 = 6000;
	
	//// rozliseni //////////////////////////////// >
	int numX = 45;
	int numY = 36;

	//// scope //////////////////////////////// >

	float ratX = width/(numX+2.0);
	float ratY = height/(numY+2.0);

	int rozdil = 0;
	int mez = 35;
	float navrat = 50.0;
	int instr,bnk;

	float ruch[] = new float[3];

	float avgX,avgY;
	float avgTX,avgTY;
	float avgSpeed = 15.0;
	float vizSpeed = 3.0;
	float sX,sY;
	//float bes = 0;

	int interval = 3;

	int channel;

	color output;

	int[] img = new int[numX*numY];
	int[] img2 = new int[numX*numY];
	boolean[][] net = new boolean[numX][numY];
	boolean[][] hraje = new boolean[numX][numY];
	int[][] counter = new int[numX][numY];

	boolean prew = false;
	boolean mute = true;

	//////////////////////////////////////////////////////////////////////////////////

	Player(PApplet _parent,int _tol,int _itvl,int _instr,int _bnk,int _channel){
		
		//ratX=ratX*1.01; //ratio obrazu


		println("/////////////////////////////////////");
		println("Translator cam->osc for orfeus 1.1 by Krystof "+
		        "Pesek aka Kof\n3.12 2007\ncopyleft by kof!");
		println("\n/////////////////////////////////////");
		println("Ratio : \n"+ratX+":"+ratY);
		for(int y = 0; y < numY;y+=1){
			for(int x = 0; x < numX;x+=1){
				net[x][y] = true;
				if((y<1)||(y>numY-2)){
					net[x][y]=false;
				}
				hraje[x][y] = false;
				counter[x][y] = 0;

			}
		}

		m = new JMyron();//obj
		m.start(numX,numY);//45,36);//320x240
		m.findGlobs(0);

		interval = _itvl*10;
		mez = _tol;

		oscMichal = new OscP5(_parent,port2);
		MichalAdd = new NetAddress(address1,port);

		oscMartin = new OscP5(_parent,port);
		MartinAdd = new NetAddress(address2,port2);

		sX=avgX=width/2.0;
		sY=avgY=height/2.0;

		m.adapt();




	}//end setup

	//////////////////////////////////////////////////////////////////////////////////

	void draw(){

		img2 = img;//m.image();
		m.update();
		img = m.differenceImage(); // !!! m.image();

		ruch[1]=0.0;

		for(int y = 0; y < numY;y+=1){
			for(int x = 0; x < numX;x+=1){
				// output =color(img[y*numX+x]);
				output =color(brightness(img[y*numX+x]));

				if(net[x][y]){
					rozdil = (int)abs(brightness(output)-brightness(img2[y*numX+x]));

					counter[x][y]++;


					if(rozdil >= mez){
						ruch[1]+=1;
						//println(x+":"+y+"   ht! - "+counter[x][y]);
						float dista = dist(x*ratX,y*ratY,avgTX,avgTY);
						dista = constrain(dista,1.0,width);
						avgTX+=((x*ratX)-avgTX)/dista;
						avgTY+=((y*ratY)-avgTY)/dista;
						counter[x][y]=0;
						fill(255);
						rect(x*ratX,y*ratY,ratX,ratY);
					}
					//text((int)(counter[x][y]/10),(int)(x*ratX+1),(int)(y*ratY+8));

				}//end if NET

				stroke(255,2);

				line(x*ratX,ratY,x*ratX,height-ratY);
				line(ratX,y*ratY,width-ratX,y*ratY);
				noStroke();

				if(prew){

					//output =lerpColor(output,#FF0000,0.75);
					fill(output);
					rect((int)(x*ratX+1),(int)(y*ratY+8),ratX,ratY);
					//rect(x*ratX,y*ratY,ratX,ratY);
				}else{

					fill(#FFCC00,map(sin(counter[x][y]/vizSpeed),-1.0,1.0,0,255));

					rect((int)(x*ratX+1),(int)(y*ratY+8),ratX,ratY);

				}

			}// end X
		}//end Y
		
		/*
		ruch[0] = abs(ruch[1]-ruch[2]);
		ruch[0]=constrain(ruch[0],1,2000);
		ruch[0]= norm(ruch[0],0,2000);
		round(ruch[0]*1000);		
		//////////////////////
		println(ruch[0]);
		//////////////////////
		*/

		ruch[1] = ruch[1]/(numX*numY)*10;
		ruch[2] += (ruch[1]-ruch[2]) / 3.0;
		ruch[2] = round(ruch[2]*1000.0)/1000.0;
		float result = map(ruch[2],0.01,0.2,0.0,1.0);
		result = round(result*1000.0)/1000.0;
		result=constrain(result,0,1);
		//println(result);

		sX=avgX;
		sY=avgY;

		

		avgX+=(avgTX-avgX)/avgSpeed;
		avgY+=(avgTY-avgY)/avgSpeed;


		//// blbost //////////////////////////////// >
		/*
		bes += ((abs(avgX-sX)+abs(avgY-sY))-bes) / avgSpeed;
		bes = constrain(bes,0.0,2.0);
		bes = map(bes,2.0,0.0,0.0,1.0);
		bes = round(bes*1000.0)/1000.0;
		*/

		stroke(255,0,0);
		line(0,avgY,width,avgY);
		line(avgX,0,avgX,height);

		//// mapovani dat //////////////////////////////// >
		if(cp.mute){
			int i = 0;
			while(i<2){
				// 0 = michal : 1 = martin
				if(i==0){
					send("/rush",result,i);
					send("/x",map(avgX,0,width-35,0,1.0),i);
					send("/y",map(avgY,0,height-35,1.0,0),i);
				}else{
					send("/rush",result,i);
					send("/x",map(avgX,0,width-35,0,1.0),i);
					send("/y",map(avgY,0,height-35,1.0,0),i);
				}
				i++;
			}




		}

		fill(255);
		text("| tol:"+mez+"| itvl:"+interval+"| x:"+numX+"| y:"+numY+"| ch:"+channel+"|",10,7);



	}//end void

	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////

	void click(){
		int X = (int)(mouseX/ratX);
		int Y = (int)(mouseY/ratY);

		if((X>=1)&&(X<=numX-1)&&(Y>=1)&&(Y<=numY-1)){
			net[X][Y] = changeState(net[X][Y]);
		}

	}

	/*
	void send(String name,int what){
		OscMessage myMessage = new OscMessage(name);
		myMessage.add(what);
		oscMichal.send(myMessage, MichalAdd);
		oscMartin.send(myMessage, MartinAdd);
		}*/
		
	//// rozesilani dat //////////////////////////////// >
	void send(String name,float what,int kam){
		if (kam==0){
			OscMessage myMessage = new OscMessage(name);
			myMessage.add(what);
			oscMichal.send(myMessage, MichalAdd);
		}else if(kam ==1){
			OscMessage myMessage2 = new OscMessage(name);
			myMessage2.add(what);
			oscMartin.send(myMessage2, MartinAdd);
		}else if(kam == 2){
			OscMessage myMessage = new OscMessage(name);
			myMessage.add(what);
			oscMichal.send(myMessage, MichalAdd);
			OscMessage myMessage2 = new OscMessage(name);
			myMessage2.add(what);
			oscMartin.send(myMessage2, MartinAdd);
		}else{
			print("toto by se nikdy nemelo stat!");
		}
	}
}//end class
//////////////////////////////////////////////////////////////////////////////////
