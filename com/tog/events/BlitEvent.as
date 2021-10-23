package com.tog.events{
	//*
	import flash.events.Event;
	import flash.display.BitmapData;
		public class BlitEvent extends Event{
			public var bitmapData:BitmapData;
			static public var READY:String = "ready";
			public function BlitEvent(_bitmapData:BitmapData, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
				super(type,bubbles,cancelable);
			    bitmapData = _bitmapData;
		}
	}
	//*/
}