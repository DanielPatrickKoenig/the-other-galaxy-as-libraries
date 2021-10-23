// ############################################################################
// Grid - lays items out in a grid
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// ############################################################################
package com.tog.composition{
	import com.tog.composition.Default;
	public class Grid extends Default{
		public var cols:int;
		public var padding:Number;
		public function Grid(_cols:int,...args){
			cols = _cols
			padding = args[0];
			if(!padding){
				padding = 0;
			}
		}
		public override function compose():void{
			var largest:Object = {wide:0, high:0};
			for(var i:int = 0;i<children.length;i++){
				if(children[i].width>largest.wide){
					largest.wide = children[i].width;
				}
				if(children[i].height>largest.high){
					largest.high = children[i].height;
				}
			}
			var h:int = 0;
			var v:int = 0;
			for(var j:int = 0;j<children.length;j++){
				children[j].x = (h*(largest.wide+padding));
				children[j].y = (v*(largest.high+padding));
				h++;
				if(h>=cols){
					h=0;
					v++;
				}
			}
		}
	}
}