/*
########################################################################
XMLCapture a class for loading xml and utilizing it once loaded
Author: Dan Koenig

########################################################################
//*/
package com.tog.data{
	import flash.events.Event;
	import com.tog.events.CaptureEvent;
	import flash.system.LoaderContext;
	import flash.events.EventDispatcher;
	import flash.net.*;
	public class XMLCapture extends EventDispatcher{
		public var xml:XML;
		private var urlLoader:URLLoader;
		public function XMLCapture(_file:String){
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = false;
			var _request:URLRequest = new URLRequest(_file);
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,loadComplete);
			urlLoader.load(_request);
		}
		private function loadComplete(e:Event):void{
			xml = new XML(e.target.data);
			dispatchEvent(new CaptureEvent(xml,CaptureEvent.COMPLETE));
		}
	}
}