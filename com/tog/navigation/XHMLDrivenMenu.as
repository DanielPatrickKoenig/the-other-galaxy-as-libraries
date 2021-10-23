/*
########################################################################
XHMLDrivenMenu a display object that hooks to an xml docuemnt
Author: Dan Koenig

########################################################################
//*/
package com.tog.navigation{
	import flash.display.Sprite;
	import com.tog.data.XMLCapture;
	import com.tog.events.CaptureEvent;
	public class XHMLDrivenMenu extends Sprite{
		private var spt:Sprite;
		private var src:String;
		public function XHMLDrivenMenu(_src:String){
			src = _src;
			var xmlCapture:XMLCapture = new XMLCapture(src,this);
			this.addEventListener(CaptureEvent.COMPLETE, xmlLoaded);
			
			
		}
		private function xmlLoaded(e:CaptureEvent):void{
			onLoaded(e.fileData);
			
			
			
		}
		public function onLoaded(_data:XML):void{
		}
	}
}
