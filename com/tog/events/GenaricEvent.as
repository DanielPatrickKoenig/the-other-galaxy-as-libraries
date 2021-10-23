// ############################################################################
// GenaricEvent - an event that monitors and calls back on the capture of data
// ============================================================================
// CREATED BY:	Dan Koenig
//
// ############################################################################
package com.tog.events{
	//*
	import flash.events.Event;
		public class GenaricEvent extends Event{
			public var data:*;
			static public var TRIGGERED:String = "triggered";
			public function GenaricEvent(_data:*, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
				super(type,bubbles,cancelable);
			    data = _data;
		}
	}
	//*/
}