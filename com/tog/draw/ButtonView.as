package com.tog.draw{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	public class ButtonView extends Sprite{
		private var format:TextFormat;
		public var txt:TextField;
		protected var _mode:int;
		private var design:DisplayObject;
		protected var data:Object;
		public function ButtonView(_text:String, ...args){
			if(args[0]){
				data = args[0];
			}
			format = createFormat();
			design = createDesign();
			addChild(design);
			txt = createText(_text,format);
			addChild(txt);
		}
		protected function createFormat():TextFormat{
			var _format:TextFormat = new TextFormat();
			_format.size = 10;
			_format.font = "Arial";
			return _format;
			
		}
		protected function createText(_text:String,_format:TextFormat):TextField{
			var _txt:TextField = new TextField();
			
			_txt.text = _text;
			_txt.selectable = false;
			_txt.autoSize = "left";
			_txt.embedFonts = true;
			_txt.setTextFormat(_format);
			_txt.defaultTextFormat = format;
			return _txt;
		}
		
		public function changeTextFormat(_property:String, _value:*):void{
			
			format[_property] = _value;
			txt.setTextFormat(format);
			txt.defaultTextFormat = format;
			
		}
		
		protected function createDesign():DisplayObject{
			var sprite:Sprite = new Sprite();
			return sprite;
		}
		public function setMode(_val:int):void{
			_mode = _val;
		}
		public function getMode():int{
			return _mode;
		}
	}
}