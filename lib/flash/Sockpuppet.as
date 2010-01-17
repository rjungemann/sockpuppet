package {
	import flash.display.Sprite;
	import flash.display.LoaderInfo;
	import flash.net.Socket;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.KeyboardEvent;
	import flash.system.Security;
	import org.osflash.thunderbolt.Logger;
	import com.teamsketchy.util.Cloak;

  public class Sockpuppet extends Sprite {
		private var socket:Socket;
	
		public function Sockpuppet() {
			var params:Object = LoaderInfo(this.root.loaderInfo).parameters;
			
			stage.frameRate = 60;
			
			socket = new Socket();

			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(Event.CLOSE, onClose);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onResponse);

			socket.connect(params["sockpuppetServer"], params["sockpuppetPort"]);
			
			Logger.about();
			Logger.info(Logger.memorySnapshot());
		}
		private function onConnect(e:Event):void {
			Logger.info("Connected!");

			socket.writeObject({ "message": "hello world" });
			socket.flush();
		}
		private function onResponse(e:ProgressEvent):void {
			Logger.info(socket.readObject().message);
		}
		private function onError(e:IOErrorEvent):void {}
		private function onClose(e:Event):void {}
  }
}