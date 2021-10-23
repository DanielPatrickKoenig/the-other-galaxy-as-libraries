// ############################################################################
// Stack - lays items out in a stack
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// ############################################################################
package com.tog.composition{
	import com.tog.composition.Default;
	public class Stack extends Default{
		public var padding:Number;
		public function Stack(...args){
			padding = args[0];
			if(!padding){
				padding = 0;
			}
		}
		public override function compose():void{
			for(var i:int = 0;i<children.length;i++){
				if(i<1){
					children[i].y = 0;
				}
				else{
					children[i].y = children[i-1].y+children[i-1].height+padding;
				}
				//children[i].x = 0;
			}
		}
	}
}