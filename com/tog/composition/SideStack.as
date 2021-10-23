// ############################################################################
// Stack - lays items out in a stack
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// ############################################################################
package com.tog.composition{
	import com.tog.composition.Stack;
	public class SideStack extends Stack{
		public function SideStack(...args){
			super(args[0]);
			
		}
		public override function compose():void{
			for(var i:int = 0;i<children.length;i++){
				if(i<1){
					children[i].x = 0;
				}
				else{
					children[i].x = children[i-1].x+children[i-1].width+padding;
				}
				//children[i].x = 0;
			}
		}
	}
}