// ############################################################################
// Default - lays items in a row
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// ############################################################################
package com.tog.composition{
	public class Default{
		public var children:Array;
		public var _children:Array;
		public var backwards:Boolean;
		public var maxWide:Number;
		public var maxHigh:Number;
		public function Default(){
		}
		public function compose():void{
			for(var i:int = 0;i<children.length;i++){
				if(i<1){
					children[i].x = 0;
				}
				else{
					children[i].x = children[i-1].x+children[i-1].width;
				}
				children[i].y = 0;
			}
		}
		public function set items(val:Array):void{
			children = val;
			_children = children;
			compose();
		}
		public function get items():Array{
			return children;
		}
		public function set reverse(val:Boolean):void{
			backwards = val;
			if(backwards){
				children.reverse();
			}
			else{
				children = _children;
			}
			compose();
		}
		public function get reverse():Boolean{
			return backwards;
		}
		public function set maxX(val:Number):void{
			maxWide = val;
		}
		public function get maxX():Number{
			return maxWide;
		}
		public function set maxY(val:Number):void{
			maxHigh = val;
		}
		public function get maxY():Number{
			return maxHigh;
		}
	}
}