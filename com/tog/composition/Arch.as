// ############################################################################
// Arch - lays items out in an arch
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// ############################################################################
package com.tog.composition{
	import com.tog.composition.Default;
	import com.tog.utils.HyperMath;
	public class Arch extends Default{
		public var radius:Number;
		public var startAngle:Number;
		public var endAngle:Number;
		public var reducer:Number;
		public function Arch(_radius:Number,...args){
			radius = _radius;
			startAngle = 0;
			endAngle = 360;
			reducer = 1;
			if(args[0]){
				startAngle = args[0];
			}
			if(args[1]){
				endAngle = args[1];
			}
			if(Math.abs(endAngle - startAngle)>355){
				reducer = 0
			}
			//startAngle-=90;
			//endAngle-=90;
		}
		public override function compose():void{
			
			for(var i:int = 0;i<children.length;i++){
				var currentAngle:Number = startAngle+(((endAngle-startAngle)/(children.length-reducer))*i);
				children[i].x = HyperMath.getOrbit(0,radius,currentAngle,"cos");
				children[i].y = HyperMath.getOrbit(0,radius,currentAngle,"sin");
			}
		}
	}
}