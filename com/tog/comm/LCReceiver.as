package com.tog.comm{
    import flash.net.LocalConnection;
	import com.tog.events.LCReceivalEvent;
	//import flash.system.Security;
	//import com.tog.events.Dispatcher;
	import flash.events.EventDispatcher;
    public class LCReceiver extends EventDispatcher{
        private var conn:LocalConnection;
        private var data:String;
		private var id:String;
		private var lcr:LCReceivalEvent;
        public function LCReceiver(_id:String){
			
			//Security.allowDomain('*');
			id = _id;
			//caller = _caller;
            conn = new LocalConnection();
			
            conn.client = this;
            try {
				conn.allowDomain('*');
                conn.connect(id);
				
            } catch (error:ArgumentError) {
                trace("Can't connect...the connection name is already being used by another SWF");
            }
        } 
        public function onReceival(_data:String):void {
			dispatchEvent(new LCReceivalEvent(_data,LCReceivalEvent.RECEIVAL));
        }
		public function destroy():void{
			conn.close();
		}
    }
}