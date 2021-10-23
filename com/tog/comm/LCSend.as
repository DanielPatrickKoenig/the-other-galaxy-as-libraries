package com.tog.comm{
    import flash.net.LocalConnection;
    import flash.events.StatusEvent;
	//import flash.system.Security;
    public class LCSend {
        private var conn:LocalConnection;
		private var id:String;
        public function LCSend(_id:String) {
			//Security.allowInsecureDomain('*');
			id = _id;
            conn = new LocalConnection();
			
            conn.addEventListener(StatusEvent.STATUS, onStatus);
        }
		
		public function send(_data:String):void{
			conn.send(id, "onReceival", _data);
		}
        
        private function onStatus(event:StatusEvent):void {
            switch (event.level) {
                case "status":
                    trace("LocalConnection.send() succeeded");
                    break;
                case "error":
                    trace("LocalConnection.send() failed");
                    break;
            }
        }
		public function destroy():void{
			conn.close();
		}
    }
}