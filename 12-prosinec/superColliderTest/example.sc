(
SynthDef("sine", { arg freq, amp; Out.ar(0, SinOsc.ar(freq, 0, amp)); }).send(s);
) 
