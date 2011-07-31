import processing.opengl.*;

import ddf.minim.analysis.*;
import ddf.minim.*;

AudioPlayer jingle;
AudioInput in;
FFT fft;
float tresh = 0.5f;
float bands[] = new float [100];
float last[] = new float [bands.length];
float thetas[] = new float[bands.length];

void setup(){
	size(512, 512,OPENGL);
	Minim.start(this);
	in = Minim.getLineIn(Minim.MONO, 512);
	fft = new FFT(in.mix.size(), 22050);
	for(int i= 0;i<bands.length;i++){
		bands[i] = 5;
		last[i] = bands[i];
		thetas[i] = 0;
	}
}

void draw(){
	background(0);
	stroke(255);
	fft.forward(in.left);
	int what = 0;
	for(int i = 0; i < fft.specSize(); i++){
		stroke(255,80);
		what = (int)map(i,0,fft.specSize(),0,bands.length);
		bands[what] += ((height - fft.getBand( i )*(8000*norm(i,0,fft.specSize())))-bands[what])/(20.0);

	}

	for(int i = 0;i<bands.length;i++){
		float q= abs(last[i]-bands[i]);
		thetas[i]+=(q+.1)/100.0f;
		thetas[i]+=(0-thetas[i])/10000.0f;
		thetas[i] += ((thetas[i]/(norm(i,fft.specSize(),-0.1f)*5))-thetas[i])/10.0f;
		q = map(q,0.0f,1.0f,0,1f);
		q=constrain(q,0,1);
		stroke(lerpColor(#FFFFFF,#FF0000,q),25);
		noFill();
		pushMatrix();
		translate(width/2.0f,height/2.0f);
		rotateZ(sin(thetas[i])*1.234f);
		box((norm(i,bands.length,1))*350);
		popMatrix();
		last[i] = bands[i];
	}

	fill(255);

}

void keyReleased()
{
	if ( key == 'w' )
	{
		fft.window(FFT.HAMMING);

	}

	if ( key == 'e' )
	{
		fft.window(FFT.NONE);

	}
}

void stop()
{
	Minim.stop();
	super.stop();
}
