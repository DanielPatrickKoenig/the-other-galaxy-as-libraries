// ############################################################################
// RecursionEvent - an event that monitors and limits recursion
// ============================================================================
// CREATED BY:	Dan Koenig
//
// ############################################################################
package com.tog.events{
	//*
	import flash.events.Event;
		public class AssetEvent extends Event{
			public var loader:*;
			static public var LOADED:String = "loaded";
			public function AssetEvent(_loader:*, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
				super(type,bubbles,cancelable);
			    loader = _loader;
		}
	}
	//*/
}