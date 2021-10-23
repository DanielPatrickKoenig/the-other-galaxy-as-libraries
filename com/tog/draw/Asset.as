// ############################################################################
// Asset - handles the loading and display of a swf, jpg, png or gif
// ============================================================================
// CREATED BY:	Dan Koenig
//
// ############################################################################
package com.tog.draw{
	import flash.display.*;
	import flash.net.URLRequest;
	import flash.events.Event;
	import com.tog.events.AssetEvent;
	public class Asset extends Sprite{
		private var fileName:String;
		private var loader:Loader;
		public function Asset(_fileName:String){
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			fileName = _fileName;
			this.addChild(loader);
			loader.load(new URLRequest(fileName));
		}
		public function loadComplete(e:Event):void{
			dispatchEvent(new AssetEvent(loader,AssetEvent.LOADED));
		}
	}
}