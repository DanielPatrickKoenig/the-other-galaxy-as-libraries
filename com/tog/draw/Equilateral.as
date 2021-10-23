// ############################################################################
// Equilateral - creates an instance of an Equilateral
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// CREATED ON: 10/18/2007
// ############################################################################
package com.tog.draw{
	import com.tog.utils.HyperMath;
	import com.tog.draw.Polygon;
	public class Equilateral extends Polygon{
		//private var container:Sprite;
		public var _sides:Number;
		public var _diameter:Number;
		public function Equilateral(...args){
			var defaultSize:Number = 72; 
			_sides = args[0];
			_diameter = args[1];
			if(!_sides){
				_sides = 6;
			}
			if(!_diameter){
				_diameter = defaultSize;
			}
			setProp(args[2],"fillColor");
			setProp(args[3],"strokeColor");
			setProp(args[4],"fillAlpha");
			setProp(args[5],"strokeAlpha");
			setProp(args[6],"strokeWeight");
			setProp(args[7],"cornerRadius");
			resetPoints();
			redraw();
		}
		private function setProp(val:*,prop:String):void{
			if(val){
				this[prop] = val;
			}
		}
		private function resetPoints():void{
			var pointList:Array = new Array();
			for(var i:Number=1;i<=_sides;i++){
				pointList.push({x:HyperMath.getOrbit(0,(_diameter/2),(i*(360/_sides)),"cos"), y:HyperMath.getOrbit(0,(_diameter/2),(i*(360/_sides)),"sin")});
			}
			this.cornerPoints = pointList;
		}
		public function set sides(val:Number):void{
			_sides = val;
			resetPoints();
			redraw();
		}
		public function set diameter(val:Number):void{
			_diameter = val;
			resetPoints();
			redraw();
		}
		public function get sides():Number{
			return _sides;
		}
		public function get diameter():Number{
			return _diameter;
		}
	}
}