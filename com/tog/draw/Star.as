// ############################################################################
// Star - creates an instance of a Star
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// CREATED ON: 10/18/2007
// ############################################################################
package com.tog.draw{
	import com.tog.utils.HyperMath;
	import com.tog.draw.Polygon;
	public class Star extends Polygon{
		//private var container:Sprite;
		public var _points:Number;
		public var _diameter:Number;
		public var _inset:Number;
		public function Star(...args){
			var defaultSize:Number = 72; 
			_points = args[0];
			_diameter = args[1];
			_inset = args[2];
			if(!_points){
				_points = 5;
			}
			if(!_diameter){
				_diameter = defaultSize;
			}
			if(!_inset){
				_inset = _diameter/2;
			}
			setProp(args[3],"fillColor");
			setProp(args[4],"strokeColor");
			setProp(args[5],"fillAlpha");
			setProp(args[6],"strokeAlpha");
			setProp(args[7],"strokeWeight");
			setProp(args[8],"cornerRadius");
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
			for(var i:Number=1;i<=_points;i++){
				pointList.push({x:HyperMath.getOrbit(0,(_diameter/2),(i*(360/_points)),"cos"), y:HyperMath.getOrbit(0,(_diameter/2),(i*(360/_points)),"sin")});
				pointList.push({x:HyperMath.getOrbit(0,(_inset/2),((i+.5)*(360/_points)),"cos"), y:HyperMath.getOrbit(0,(_inset/2),((i+.5)*(360/_points)),"sin")});
			}
			this.cornerPoints = pointList;
		}
		public function set points(val:Number):void{
			_points = val;
			resetPoints();
			redraw();
		}
		public function set diameter(val:Number):void{
			_diameter = val;
			resetPoints();
			redraw();
		}
		public function set inset(val:Number):void{
			_inset = val;
			resetPoints();
			redraw();
		}
		public function get points():Number{
			return _points;
		}
		public function get diameter():Number{
			return _diameter;
		}
		public function get inset():Number{
			return _inset;
		}
	}
}