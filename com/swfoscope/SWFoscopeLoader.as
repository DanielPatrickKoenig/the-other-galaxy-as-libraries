package com.swfoscope{
	import flash.display.Sprite;
	import com.tog.utils.ProgressiveLoaderAS3;
	import com.tog.events.RecursionEvent;
	import com.swfoscope.SWFoscope;
	import com.tog.draw.Box;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.system.Security;
	public class SWFoscopeLoader extends Sprite{
		private var container:Sprite;
		private var nav:Sprite;
		private var tf:TextField;
		private var box:Box;
		public function SWFoscopeLoader(){
			Security.allowInsecureDomain('*');
			nav = new Sprite();
			addChild(nav);
			tf = new TextField();
			nav.addChild(tf);
			tf.type = "input";
			tf.x = 20;
			tf.y = 20;
			tf.width = 300;
			tf.height = 20;
			tf.border = true;
			tf.text = "Enter a path to a swf file";
			box = new Box();
			nav.addChild(box);
			box.x = tf.x+tf.width+5;
			box.y = tf.y;
			box.wide = tf.height*2;
			box.high = tf.height;
			box.addEventListener(MouseEvent.MOUSE_DOWN, loadFile);
		}
		private function loadFile(e:MouseEvent):void{
			container = new Sprite();
			addChild(container);
			//var eventHub:Sprite = this;
			var loadList:Array = [{displayObject:container, asset:tf.text}];
			var pg:ProgressiveLoaderAS3 = new ProgressiveLoaderAS3(loadList);
			pg.addEventListener(RecursionEvent.COMPLETE, startProbe);
			removeChild(nav);
		}
		private function startProbe(e:RecursionEvent):void{
			var swfoscope:SWFoscope = new SWFoscope(container);
		}
	}
}