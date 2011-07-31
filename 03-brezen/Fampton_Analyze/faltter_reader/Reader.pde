


class Reader{
	
	String[] raw;
	String filename;
	int data[];
	int len = 0;
	int zalomeni = 300;
	int shift = 0;

	Reader(String _filename){
		filename=_filename+".dat";
		raw = loadStrings(filename);
		len  = raw.length;
		data = new int[len];
		
		derive();
	}


	void compute(){
		int radek = 0;
		for(int i = 0;i<len;i++){
			stroke(data[i]);
			if((i+shift)%zalomeni==0){radek++;}
			line(((i+shift)%zalomeni),radek*10,((i+shift)%zalomeni),radek*10+10);

		}
		zalomeni = (int)((sin(frameCount/1000.0f)+1)*width/2);//
		//zalomeni =(int)mouseX;
		zalomeni = constrain(zalomeni,1,width);

		
	}

	void derive(){
		for(int i = 0;i<len;i++){
			data[i] = parseInt(raw[i]);
		}
		println("filename loaded!");

	}

	void draw(){



	}



}


