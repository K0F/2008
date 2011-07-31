(
SynthDef("variablesine", { arg freq;
	var f, g, osc;
	
	osc = RLPF.ar(LFPulse.ar(SinOsc.kr(freq, 0, 10, 21), 0.1), 100, 0.1).clip2(0.4);
	Out.ar(0, osc);
}).writeDefFile; 
s.sendSynthDef("variablesine");
)

(
SynthDef("def", { arg freq;
	var f, g, osc;

	osc = CombL.ar(
		RLPF.ar(LFPulse.ar(FSinOsc.kr(freq,0,80,160),0,0.4,0.05), 
		   FSinOsc.kr([0.6,0.7],0,3600,4000), 0.2),
		0.3, [0.2,0.25], 2);
	Out.ar(0, osc);
}).writeDefFile;
s.sendSynthDef("def");
)

(
SynthDef("scratchy", { arg freq;
	var f, g, osc;
	osc = RHPF.ar(BrownNoise.ar([0.5,0.5], -0.49).max(0) * 20, 5000, 1);
	Out.ar(0, osc);
}).writeDefFile;
s.sendSynthDef("scratchy");
)

(
SynthDef("scratchy", { arg freq1, freq2, freq3;
	var f, g, osc;
	osc = RHPF.ar(BrownNoise.ar([freq1,freq2], -0.49).max(0) * freq3, 5000, 1);
	Out.ar(0, osc);
}).writeDefFile;
s.sendSynthDef("scratchy");
)

(
SynthDef("sprinkler", { arg freq;
	var f, g, osc;
	osc = BPZ2.ar(WhiteNoise.ar(LFPulse.kr(MouseX.kr(0.2,50), 0, 0.25, 0.1)));
	Out.ar(0, osc);
}).writeDefFile;
s.sendSynthDef("sprinkler");
)

(
SynthDef("liquid", {
	var clockRate, clockTime, clock, centerFreq, freq, panPos, patch;

	clockRate = MouseX.kr(1, 200, 1);
	clockTime = clockRate.reciprocal;
	clock = Impulse.kr(clockRate, 0.4);

	centerFreq = MouseY.kr(100, 8000, 1);
	freq = Latch.kr(WhiteNoise.kr(centerFreq * 0.5, centerFreq), clock);
	panPos = Latch.kr(WhiteNoise.kr, clock);
	patch = CombN.ar(
			Pan2.ar( 
				SinOsc.ar(
					freq, 
					0, 
					Decay2.kr(clock, 0.1 * clockTime, 0.9 * clockTime)
				), 
				panPos
			),
			0.3, 0.3, 2
		);
	Out.ar(0, patch);
}).writeDefFile;
s.sendSynthDef("liquid");
)

