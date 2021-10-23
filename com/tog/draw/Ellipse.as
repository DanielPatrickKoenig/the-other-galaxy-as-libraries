// ############################################################################
// Ellipse - creates an instance of an Ellipse
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// CREATED ON: 10/18/2007
// ############################################################################
package com.tog.draw{
	import com.tog.utils.HyperMath;
	import com.tog.draw.Polygon;
	public class Ellipse extends Polygon{
		//private var container:Sprite;
		public var _wide:Number;
		public var _high:Number;
		private var _sides:Number;
		private var rad:Number;
		public function Ellipse(...args){
			var defaultSize:Number = 72; 
			_wide = args[0];
			_high = args[1];
			_sides = 8;
			if(!_wide){
				_wide = 6;
			}
			if(!_high){
				_high = _wide;
			}
			setProp(args[2],"fillColor");
			setProp(args[3],"strokeColor");
			setProp(args[4],"fillAlpha");
			setProp(args[5],"strokeAlpha");
			setProp(args[6],"strokeWeight");
			resetPoints();
			redraw();
		}
		private function setProp(val:*,prop:String):void{
			if(val){
				this[prop] = val;
			}
		}
		private function resetPoints():void{
			if(wide>high){
				rad = wide;
			}
			else{
				rad = high;
			}
			setProp(rad,"cornerRadius");
			var pointList:Array = new Array();
			for(var i:Number=1;i<=_sides;i++){
				pointList.push({x:HyperMath.getOrbit(wide/2,(_wide/2),(i*(360/_sides)),"cos"), y:HyperMath.getOrbit(high/2,(_high/2),(i*(360/_sides)),"sin")});
			}
			this.cornerPoints = pointList;
		}
		public function set wide(val:Number):void{
			_wide = Math.abs(val);
			resetPoints();
			redraw();
		}
		public function set high(val:Number):void{
			_high = Math.abs(val);
			resetPoints();
			redraw();
		}
		public function get wide():Number{
			return _wide;
		}
		public function get high():Number{
			return _high;
		}
	}
}