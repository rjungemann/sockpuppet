Sockpuppet - Complete Ruby/ActionScript socket client/server with AMF
by Roger Jungemann
=================================================

Sockpuppet consists of a Ruby server, based on EventMachine, which can communicate with ActionScript clients using sockets. Communication over HTTP requires a request and response, and the connection may not stay open between request/response cycles. If one uses sockets, this overhead can be avoided.

The client and server communicate with each other using a binary serialization format known as AMF. AMF is often much faster than XML or JSON since it is binary.

To get started, check out the code, then change into the "sockpuppet" directory. Once you're there, make sure you have the "eventmachine" and "thin" gems installed. Then run "rake vendor" to download the remaining necessary software. Then in one Terminal, run "rake sockpuppet:run" to start the server. In another Terminal, run "rake && rake run" to start the client and run it. If "rake run" fails, open "http://localhost:4567/flash/index.html" with Firefox. If you have the Firebug add-on for Firefox installed, you can open up the Firebug Console to view debug data.

To extend the server, take a look at "lib/apps/sockpuppet_socket.rb". In the future you will be able to add your own functionality. For the moment you can just edit it. The client source is found in "lib/flash".