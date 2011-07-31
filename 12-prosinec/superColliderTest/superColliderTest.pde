import supercollider.*;

Synth synth[] = new Synth[2];

void setup ()
{
	size(300, 200,P3D);
	frameRate(30);

	// uses default sc server at 127.0.0.1:57110
	// does NOT create synth!
	synth[0] = new Synth("def");
	//synth[1] = new Synth("sprinkler");

	// set initial arguments
	//synth.set("amp", 0.5);                        
	//var clockRate, clockTime, clock, centerFreq, freq, panPos, patch;
	synth[0].set("freq", 80);
		//synth[0].set("amp", 0.5);

	//synth[1].set("freq", 80);
	
	// create synth
	synth[0].create();
	//synth[1].create();
}

float pos = 0;

void draw ()
{
	background(0);
	stroke(255);
	
	pos = 2.0*(sin(frameCount/130.0)+1.01);
	synth[0].set("freq",pos);
	line(map(pos,0,500,0,width), 0, map(pos,0,500,0,width), height);
}

void mouseMoved ()
{
	//synth[0].set("freq", map(mouseX,0,width,20,5000));
	synth[0].set("amp", map(mouseY,0,height,0,1000));
}

void stop ()
{
	synth[0].free();
	//synth[1].free();
}

