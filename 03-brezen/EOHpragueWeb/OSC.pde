
class OSC{
	OscP5 osc;
	NetAddress addr;
	int port;

	OSC(String _addr,int _port){
		port=_port;
		osc = new OscP5(this,_port);
		addr = new NetAddress(_addr,port+1);
	}

	void send(int _ident,float _whatX,float _whatY){
		OscMessage message = new OscMessage("/osc");
		message.add(_ident);
                //message.add("x ");
		message.add(_whatX);
		//message.add("y ");
		message.add(_whatY);
		osc.send(message, addr);
	}

}
