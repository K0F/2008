
Commander c;


void seup(){
	size(200,200);

	c = new Commander(this);

}

void draw (){
	background(0);
}

void keyPressed(){
	if(!c.started){
		c.execute("cd ..");
		
	}
}









class Commander{

	String command;
	boolean started = false;
	PApplet parent;
	
	Commander(PApplet _parent){
		parent=_parent;

	}

	void execute(String _command){
		started = true;
		command = _command+"";
		//println(Runtime.getRuntime()+"");
		try{
			Runtime.getRuntime().exec("gnome-terminal -x "+command);
			println("sucess!");
		}catch(java.io.IOException e){
			println(e);
		}
	}


}
