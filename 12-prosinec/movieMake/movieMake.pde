MovieMaker m;
boolean recording  = true;


void setup(){
	size(200,200);
	background(0);
	m = new MovieMaker(this,"out","test.avi");

}


void draw(){
	background(128*(sin(frameCount*0.01)+1.0));

	if(recording)
		m.add();

}

void keyPressed(){
	if(key == 'q'){
		if(recording)
			m.finish();
		exit();
	}

}




class MovieMaker extends Thread{
	String filename;
	String dir;
	PApplet parent;

	PrintWriter output;
	int frame = 0;

	MovieMaker(PApplet _parent,String _dir,String _filename){
		parent=_parent;
		filename = _filename+"";
		dir = _dir+"";
		output = createWriter(dir+"/"+filename+".dat");
		frame = frameCount;
		parent.loadPixels();
	}

	void add(){
		loadPixels();
		int[] temp = parent.pixels;
		byte tempB;
		for(int i =0;i<temp.length;i++){
			//tempB = (byte)temp[i];
			output.print((hex((byte)temp[i]))+" ");
		}
		output.println("");
	}


	void finish(){
		output.flush();
		output.close();


		println("signal caught; finishing movie ..");
		//String Path = sketchPath+"/"+dir;
		/*try{
			Runtime.getRuntime().exec("gnome-terminal -x png2vid "+Path+" "+filename"");
			println("finishing");
	}
		catch(java.io.IOException e){
			println(e);
	}*/
	}
}
