package com.swfoscope.draw{
	import com.swfoscope.draw.SWFoscopeNavShape;
	
	public class SWFoscopeNavButtonTextBar extends SWFoscopeNavShape{
		protected override function resetPoints():void{
			if(rad>wide/2 || rad>high/2){
				if(wide>high){
					rad = wide;
				}
				else{
					rad = high;
				}
			}
			
			_sides = 20;
			var curveAmount:Number = 110;
			var curveBalance:Number = (180-curveAmount)/2;
			
			var pointList:Array = [plotOrbit(0,curveAmount,curveBalance),plotOrbit(0,curveAmount,curveBalance,wide),plotOrbit(_sides,curveAmount,curveBalance,wide)];
			
			for(var i:Number=_sides;i>0;i--){
				pointList.push(plotOrbit(i,curveAmount,curveBalance));
				//pointList.push({x:HyperMath.getOrbit(0,(_wide/2),(i*(curveAmount/_sides)+curveBalance),"cos"), y:HyperMath.getOrbit(_high/2,(_high/2),(i*(curveAmount/_sides)+curveBalance),"sin")});
			}
			//pointList.push();
			setProp(rad,"cornerRadius");
			
			this.cornerPoints = pointList;
		}
	}
}