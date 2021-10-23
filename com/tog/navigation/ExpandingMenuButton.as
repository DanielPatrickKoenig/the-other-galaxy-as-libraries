// ############################################################################
// RectangularButton - a simple button with text
// ============================================================================
// CREATED BY:	Dan Koenig -- dpkoenig27@yahoo.com
//
// CREATED ON: 11/28/08
// ############################################################################
package com.tog.navigation{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.tog.events.ToggleEvent;
	import com.tog.draw.Box;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class ExpandingMenuButton extends Sprite{
		public var partner:*;
		public var subMenu:DisplayObjectContainer;
		private var txt:TextField;
		private var _mode:int;
		private var format:TextFormat;
		private var id:String;
		private var toggle:Sprite;
		private var toggleBox:Box;
		private var toggleSymbol:Sprite;
		public function ExpandingMenuButton(){
			format = new TextFormat();
			format.size = 10;
			format.font = "Arial";
			txt = new TextField();
			toggle = new Sprite();
			toggleBox = new Box();
			toggleBox.cornerRadius = 0;
			toggleBox.wide = 20;
			toggleBox.high = 20;
			addChild(toggle);
			toggle.addChild(toggleBox);
			_mode = 0;
			txt.x = toggle.width+toggle.x;
			addChild(txt);
			
			//txt.html = true;
			txt.selectable = false;
			txt.autoSize = "left";
			
			//toggle.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
		}
		private function clicked(e:ToggleEvent):void{
			dispatchEvent(new ToggleEvent(this,ToggleEvent.CHANGE));
		}
		public function setText(_val:String):void{
			txt.htmlText = "<P><FONT SIZE='8'>"+_val+"</FONT></P>";
			setId(_val);
			//if(txtBlocker){
				//removeChild(txtBlocker);
			//}
			
			txt.embedFonts = true;
			txt.setTextFormat(format);
		}
		
		public function setId(_val:String):void{
			id = _val;
		}
		public function getId():String{
			return id;
		}
		
		public function setMode(_val:int):void{
			_mode = _val;
		}
		public function getMode():int{
			return _mode;
		}
		
	}
}