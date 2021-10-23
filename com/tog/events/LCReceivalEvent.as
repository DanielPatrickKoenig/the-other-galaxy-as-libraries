package com.tog.events{
	import flash.events.Event;
	public class LCReceivalEvent extends Event{
		public var data:String;
		public static const RECEIVAL:String = "receival";
		
		public function LCReceivalEvent(_data:String, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type,bubbles,cancelable);
			data = _data
		}
	}
}
/*
package com.tog.events{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	public class LCReceivalEvent extends EventDispatcher{
		public var data:String;
		public static const RECEIVAL:String = "receival";
		public function LCReceivalEvent(){
			
		}
		public function received(_data:String):void{
			data = _data;
			dispatchEvent(new Event(LCReceivalEvent.RECEIVAL, true));
		}
	}
}
//*/