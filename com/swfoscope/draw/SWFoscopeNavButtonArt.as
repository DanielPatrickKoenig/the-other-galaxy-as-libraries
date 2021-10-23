// ############################################################################
// RectangularButton - a simple button with text
// ============================================================================
// CREATED BY:	Dan Koenig -- dpkoenig27@yahoo.com
//
// CREATED ON: 11/28/08
// ############################################################################
package com.swfoscope.draw{
	import com.tog.draw.ButtonView;
	import flash.geom.Matrix;
	import com.swfoscope.draw.SWFoscopeNavButtonTextBar;
	import com.swfoscope.draw.SWFoscopeNavButtonArrow;
	import com.tog.draw.Ellipse;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class SWFoscopeNavButtonArt extends ButtonView{
		private var arrowContainer:Sprite;
		private var highlight:Ellipse;
		public function SWFoscopeNavButtonArt(_text:String, ...args){
			super(_text, args[0]);
			txt.x = 40;
		}
		protected override function createFormat():TextFormat{
			var _format:TextFormat = new TextFormat();
			_format.size = 20;
			_format.font = "Arial";
			_format.color = 0xFFFFFF;
			return _format;
			
		}
		
		protected override function createDesign():DisplayObject{
			var sprite:Sprite = new Sprite();
			
			var navButtonTextBar:SWFoscopeNavButtonTextBar = new SWFoscopeNavButtonTextBar();
			navButtonTextBar.x = 15;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(80, 80, Math.PI/2, 0, 0);
			navButtonTextBar.fillColor = {type:"linear", colors:[0x5FDEFE, 0x00CCFF, 0x00A4FF, 0x0099FF], alphas:[100, 100, 100, 100] ,ratios:[0x00, 0x33, 0x39, 0xCC], matrix:matrix};
			sprite.addChild(navButtonTextBar);
			
			arrowContainer = new Sprite();
			sprite.addChild(arrowContainer);
			if(Number(data.children)>0){
				var navButtonArrow:SWFoscopeNavButtonArrow = new SWFoscopeNavButtonArrow();
				arrowContainer.x = 15
				arrowContainer.y = 15;
				//arrowContainer.rotation = 90;
				navButtonArrow.y = -15;
				arrowContainer.addChild(navButtonArrow);
			}
			var circle1:Ellipse = drawCircle(25);
			addChild(circle1);
			if(Number(data.children)>0){
				var circle2:Ellipse = drawCircle(22);
				circle2.fillColor = 0x666666;
				addChild(circle2);
			}
			highlight = drawCircle(15);
			addChild(highlight);
			
			return sprite;
		}
		
		public function activateHighlight():void{
			highlight.fillColor = 0xCC0000;
		}
		
		public function deactivateHighlight():void{
			highlight.fillColor = 0x000000;
		}
		
		private function drawCircle(_size:Number):Ellipse{
			var circle:Ellipse = new Ellipse();
			circle.wide = _size;
			circle.high = _size;
			circle.x = (30-circle.wide)/2;
			circle.y = (30-circle.wide)/2;
			return circle;
		}
		public override function setMode(_val:int):void{
			_mode = _val;
			arrowContainer.rotation = _mode*90;
		}
		
	}
}