// ############################################################################
// ProgressiveLoaderAS3 - a basic chain asset loader
// ============================================================================
// CREATED BY:	Dan Koenig
//
// CREATED ON: 10/18/2007
// ############################################################################
package com.tog.utils{
	import flash.display.*;
	import flash.net.URLRequest;
	import flash.events.Event;
	import com.tog.events.RecursionEvent;
	import flash.events.EventDispatcher;
	public class ProgressiveLoaderAS3 extends EventDispatcher{
		public var list:Array;
		public var num:int;
		//public var list:Array;
		public function ProgressiveLoaderAS3(_list:Array){
			num = 0;
			list = _list;
			loadImage();
		}
		public function loadImage():void{
			if(list.length == num){
				dispatchEvent(new RecursionEvent(list,RecursionEvent.COMPLETE));
			}
			else{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,continueLoad);
				var dObject:DisplayObjectContainer = list[num].displayObject;
				var fileName:String = list[num].asset;
				dObject.addChild(loader);
				loader.load(new URLRequest(list[num].asset));
			}
		}
		public function continueLoad(e:Event):void{
			num++;
			if(num<=list.length){
				loadImage();
				//method();
				
			}
			else{
				//method();
				//caller.dispatchEvent(new RecursionEvent(list,RecursionEvent.COMPLETE));
			}
		}
	}
}