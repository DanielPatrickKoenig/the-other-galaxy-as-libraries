// ############################################################################
// RecursionEvent - an event that monitors and limits recursion
// ============================================================================
// CREATED BY:	Dan Koenig
//
// ############################################################################
package com.tog.events{
	//*
	import flash.events.Event;
	import flash.display.DisplayObject;
		public class ToggleEvent extends Event{
			public var device:DisplayObject;
			public var mode:Boolean;
			static public var CHANGE:String = "change";
			public function ToggleEvent(_device:*, type:String, bubbles:Boolean = false, cancelable:Boolean = false, _mode:Boolean = false){
				super(type,bubbles,cancelable);
			    device = _device;
				mode = _mode;
		}
	}
	//*/
}