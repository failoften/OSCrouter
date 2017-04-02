import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress Vezer;
NetAddress Resolume;
NetAddress QuickOSC;

void setup() {
  size(400,400);
  frameRate(25);
  // start oscP5, listen for incoming messages at port 8000
  oscP5 = new OscP5(this,2124);
  
  // a remote address.
  // incoming messages will be forwarded to this address
  Vezer = new NetAddress("127.0.0.1",1234);
  Resolume = new NetAddress("127.0.0.1",8000);
  QuickOSC = new NetAddress("192.168.1.3",2125);
}


void draw() {
  background(0);  
}

// for testing purposes.
// press key 1 to send a message to port 8000 on your local machine

void keyPressed() {
  OscMessage myMessage;
  switch(key) {
    case('1'):
    myMessage = new OscMessage("/test");
    myMessage.add(1);
    NetAddress n = new NetAddress("127.0.0.1",8000);
    oscP5.send(myMessage, n); 
    println("sending a message to "+n);
    break;
}
}


void oscEvent(OscMessage theOscMessage) {
    // oscP5 is listening at port 8000 (see setup).
    // incoming messages are sent to the oscEvent method.
    println("received a message.");
    
    // forwarding the same message to another address/port:

    // if you need to change the address pattern of the message
    // you just received, use:
    //theOscMessage.setAddrPattern("/vezer/blackout/play 1");

    // now forward the message by sending it to your remote address.
    oscP5.send(theOscMessage, Resolume);
    oscP5.send(theOscMessage, Vezer);
    println("forwarding " + theOscMessage + " to " + Resolume + " and " + Vezer);
    fill(50);
    String s = "SENDING";
    text(s, 200, 200);  // Text wraps within text box
}
