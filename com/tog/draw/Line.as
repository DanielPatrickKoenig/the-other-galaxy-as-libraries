// ############################################################################
// Line - creates an instance of a line
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// CREATED ON: 10/18/2007
// ############################################################################
package com.tog.draw{
	import com.tog.draw.Polygon;
	public class Line extends Polygon{
		public function Line(...args){
			if(args[0] == null){
				args[0] = [{x:0,y:0},{x:72,y:0}];
			}
			if(args[1] == null){
				args[1] = 0x000000;
			}
			if(args[2] == null){
				args[2] = 1;
			}
			if(args[3] == null){
				args[3] = 1;
			}
			if(args[4] == null){
				args[4] = 4;
			}
			corners = args[0];
			setProp(args[1],"strokeColor");
			setProp(args[2],"strokeAlpha");
			setProp(args[3],"strokeWeight");
			setProp(args[4],"cornerRadius");
			closedShape = false;
			redraw();
		}
		private function setProp(val:*,prop:String):void{
			if(val){
				this[prop] = val;
			}
		}
	}
}