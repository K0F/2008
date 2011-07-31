/*
* self exhiber by krystof pesek
* can be a code itself an art?
*
*/

// var holds a code
String code[];

// setup
void setup (){

	// load a source first
	code = loadStrings("rien.pde");
	// create size of frame depend on code length
	size(300,code.length*10+20);
	// background once
	background(0);
	// create font for displaying
	textFont(createFont("Veranda",9));
	// no contours please
	noStroke();
}

                                                                                                                                                                                                                                                     
void draw(){
	// semi transluent background 155?
	fill(0,155);
	rect(0,0,width,height);

	// hey its a code poetry!

	// loop for displaying text
	for(int i =0;i<code.length;i++){
		if(code[i].indexOf("//")>-1){ //bad code :)
			fill(55);
		}else{
			fill(255);
		}
		text(code[i]+"",
		     20+sin(frameCount/(10.0+i))*5,
		     i*10+10+cos(frameCount/(10.0+i))*2);

	}
}


