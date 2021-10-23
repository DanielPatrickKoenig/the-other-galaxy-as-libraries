// ############################################################################
// RecursionEvent - an event that monitors and limits recursion
// ============================================================================
// CREATED BY:	Dan Koenig
//
// ############################################################################
package com.tog.events{
	//*
	import flash.events.Event;
		public class RecursionEvent extends Event{
			public var list:*;
			static public var COMPLETE:String = "complete";
			public function RecursionEvent(_list:*, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
				super(type,bubbles,cancelable);
			    list = _list;
		}
	}
	//*/
}