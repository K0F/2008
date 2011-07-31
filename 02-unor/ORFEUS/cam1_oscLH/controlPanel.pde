////////////////////////////////////////////////////////////////////////////////// GUI

class CPanel{

	String[] writer = new String[player.numY*player.numX];
	String ext = ".png";
	String[] names = {"run","save","load","bank1","bank2","bank3","bank4","bank5","mute"};
	PImage[] shorts = new PImage[names.length];
	int x,y;
	int[] X = new int[names.length];
	int[] Y = new int[names.length];
	int pre = 0;
	boolean mute = false;

	//////////////////////////////////////////////////////////////////////////////////

	CPanel(int _x,int _y){
		x=_x;
		y=_y;

		for(int i = 0;i<names.length;i++){
			names[i] += ext;
			shorts[i] = loadImage(names[i]);
			int posun = i;
			//if(posun>0){posun+=1;}
			X[i] = x+shorts[0].width*posun;
			Y[i] = y;
		}
	}

	//////////////////////////////////////////////////////////////////////////////////

	void run(){

		for(int i = 0;i<shorts.length;i++){
			pushMatrix();
			translate(X[i],Y[i]);

			if(over(i)){
				tint(#FFaaaa,255);

			}else{
				noTint();

			}

			if(pre+3==i){
				tint(#FF0000,128*(sin(frameCount/5.0)+1));
			}

			if((mute)&&(i==shorts.length-1)){
				tint(#FF0000,128*(sin(frameCount/2.5)+1));
			}

			image(shorts[i],0,0);

			popMatrix();
		}


	}

	//////////////////////////////////////////////////////////////////////////////////

	boolean over(int i){
		boolean an = false;
		if((mouseX>X[i])&&(mouseX<X[i]+shorts[i].width)&&(mouseY>Y[i])&&(mouseY<Y[i]+shorts[i].height)){
			an = true;
		}
		return an;
	}

	void action(int i){
		switch(i){
		case 0:
			erase();
			break;

		case 1:
			write();
			break;

		case 2:
			read();
			break;

		case 3:
			pre = 0;
			break;

		case 4:
			pre = 1;
			break;

		case 5:
			pre = 2;
			break;

		case 6:
			pre = 3;
			break;

		case 7:
			pre = 4;
			break;
		case 8:
			mute=changeState(mute);
			//mut();
			break;
		}
	}

	//////////////////////////////////////////////////////////////////////////////////

	void write(){
		for(int y = 0; y < player.numY;y+=1){
			for(int x = 0; x < player.numX;x+=1){
				if(player.net[x][y]){
					writer[y*player.numX+x] = ""+1;
				}else{
					writer[y*player.numX+x] = ""+0;
				}//if

			}//forY
		}//end forX
		//println(writer);
		saveStrings("presets/pozice"+pre+".kof",writer);
	}

	//////////////////////////////////////////////////////////////////////////////////

	void read(){
		writer = loadStrings("presets/pozice"+pre+".kof");
		for(int y = 0; y < player.numY;y+=1){
			for(int x = 0; x < player.numX;x+=1){
				if(writer[y*player.numX+x].equals("0")){
					player.net[x][y] = false;
				}else{
					player.net[x][y] = true;
				}//end if

			}//end y
		}//end x
	}//end void

	//////////////////////////////////////////////////////////////////////////////////

	void erase(){
		for(int y = 0; y < player.numY;y+=1){
			for(int x = 0; x < player.numX;x+=1){
				player.net[x][y] = false;
			}
		}

	}

	//////////////////////////////////////////////////////////////////////////////////



}//end class

//////////////////////////////////////////////////////////////////////////////////
