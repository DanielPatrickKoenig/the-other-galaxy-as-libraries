package com.swfoscope.draw{
	import com.swfoscope.draw.SWFoscopeNavShape;
	
	public class SWFoscopeNavButtonArrow extends SWFoscopeNavShape{
		public function SWFoscopeNavButtonArrow(...args){
			
			wide = high*.75;
		}
		protected override function setCurveData():Object{
			var curveAmount:Number = 90;
			var curveBalance:Number = (180-curveAmount)/2;
			return {a:curveAmount, b:curveBalance};
		}
	}
}