package com.tog.events{
	//*
	import flash.events.Event;
		public class StateEvent extends Event{
			static public var CHANGE:String = "change";
			public function StateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false){
				super(type,bubbles,cancelable);
		}
	}
	//*/
}