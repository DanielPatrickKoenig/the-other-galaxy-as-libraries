// ############################################################################
// RectangularButton - a simple button with text
// ============================================================================
// CREATED BY:	Dan Koenig -- dpkoenig27@yahoo.com
//
// CREATED ON: 11/28/08
// ############################################################################
package com.tog.navigation{
	import com.tog.draw.Box;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import com.tog.draw.ButtonView;
	import flash.display.SimpleButton;
	public class RectangularButton extends SimpleButton{
		public var partner:*;
		public var subMenu:DisplayObjectContainer;
		private var _mode:int;
		private var id:String;
		//private var txtBlocker:Box;
		private var view:ButtonView;
		public function RectangularButton() {
			
			
			_mode = 0;
			//addChild(txt);
			
			//txt.html = true;
			
			
			
		}
		
		
		public function setId(_val:String):void{
			id = _val;
		}
		public function getId():String{
			return id;
		}
		
		public function setMode(_val:int):void{
			_mode = _val;
			//*
			
			view.setMode(_mode);
			
			
			//*/
			
		}
		public function getMode():int{
			return _mode;
		}
		public function setView(_val:ButtonView):void{
			
			view = _val;
			downState = view;
			overState = view;
			upState = view;
			hitTestState = view;
		}
		public function getView():ButtonView{
			return view;
		}
	}
}