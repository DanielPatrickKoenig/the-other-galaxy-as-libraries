// ############################################################################
// CaptureEvent - an event that monitors and calls back on the capture of data
// ============================================================================
// CREATED BY:	Dan Koenig
//
// ############################################################################
package com.tog.events{
	//*
	import flash.events.Event;
		public class CaptureEvent extends Event{
			public var fileData:*;
			static public var COMPLETE:String = "complete";
			public function CaptureEvent(_fileData:*, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
				super(type,bubbles,cancelable);
			    fileData = _fileData;
		}
	}
	//*/
}