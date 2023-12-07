
// set input / output device

// the following loads sounds from the directory in which this file is located. the sound files are made available to the user in Buffers -- client-side representations of sampled audio stored in memory and available to the server for playing.
s.boot;

s.waitForBoot {
	{
        b = [\GhatamSample1, \GhatamSample2, \GhatamSample3].collect { |val|
            Buffer.read(s, (val ++ ".wav").resolveRelative);
        };
    }.value;
	// a very simple sample-playing instrument.
	{
		(
			SynthDef(\playBuf,
				{ |buffer, start = 0, dur = 0.25, amp = 1|
					var sig = PlayBuf.ar(1,buffer,startPos: start, loop: 0);
					var env = EnvGen.kr(Env.linen(0.01,dur,0.01,level:amp),doneAction:2);
					Out.ar(0,(sig*env) !2);
				}
			).add;
		)
	}.value;


	{
		//Synth(\playBuf, [\buffer, b[2]]); // uncomment and use this line to hear indiviual sounds stored in buffers.
	}.value;
	// Register an OSCdef object to receive *any* message to the local language
	{
		(
			OSCdef(\anyMessage, {|msg| msg.postln;
				Synth(\playBuf, [\buffer, msg[1] ]); // take the incoming data and index into the buffer array
			}, '\aMessage');
		)
	}.value;
}

//
// OSCFunc.trace(true);
// OSCFunc.trace(false);
// OSCdef.freeAll;
// /*____________________________________________________________
//
// For testing/spoofing your OSCFuncs/OSCdefs: these would come from Python in your project
// _____________________________________________________________*/
//
// m = NetAddr("127.0.0.1", NetAddr.langPort); // local machine
// // testing
// m.sendMsg("/aMessage", 0); // your OSCFunc must be registered to look for this message or have .trace turned on.
// m.sendMsg("/aMessage", 1); // the data following the "path" can be anything.
// m.sendMsg("/aMessage", 2); // the same message can be used to send indices
// m.sendMsg("/aMessage", 3); // into an array that contain your samples


