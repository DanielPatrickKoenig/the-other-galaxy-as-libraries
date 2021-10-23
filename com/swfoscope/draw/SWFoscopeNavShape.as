package com.swfoscope.draw{
	import com.tog.utils.HyperMath;
	import com.tog.draw.Polygon;
	public class SWFoscopeNavShape extends Polygon{
		public var _wide:Number;
		public var _high:Number;
		protected var _sides:Number;
		protected var rad:Number;
		public function SWFoscopeNavShape(...args){
			var defaultSize:Number = 30;
			_wide = args[0];
			_high = args[1];
			//_sides = 8;
			rad = 2;
			if(!_wide){
				_wide = 300;
			}
			if(!_high){
				_high = defaultSize;
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
		protected function setProp(val:*,prop:String):void{
			if(val){
				this[prop] = val;
			}
		}
		protected function resetPoints():void{
			if(rad>wide/2 || rad>high/2){
				if(wide>high){
					rad = wide;
				}
				else{
					rad = high;
				}
			}
			
			_sides = 20;
			var curveData:Object = setCurveData();
			var curveAmount:Number = curveData.a;
			var curveBalance:Number = curveData.b;
			
			var pointList:Array = [plotOrbit(0,curveAmount,curveBalance),plotOrbit(_sides/2,curveAmount,curveBalance,wide)];
			
			for(var i:Number=_sides;i>0;i--){
				pointList.push(plotOrbit(i,curveAmount,curveBalance));
				//pointList.push({x:HyperMath.getOrbit(0,(_wide/2),(i*(curveAmount/_sides)+curveBalance),"cos"), y:HyperMath.getOrbit(_high/2,(_high/2),(i*(curveAmount/_sides)+curveBalance),"sin")});
			}
			//pointList.push();
			setProp(rad,"cornerRadius");
			
			this.cornerPoints = pointList;
		}
		protected function setCurveData():Object{
			var curveAmount:Number = 110;
			var curveBalance:Number = (180-curveAmount)/2;
			return {a:curveAmount, b:curveBalance};
		}
		protected function plotOrbit(index:int,curveAmount:Number,curveBalance:Number, ...args):Object{
			var outputObject:Object = {x:HyperMath.getOrbit(0,(_high/2),(index*(curveAmount/_sides)+curveBalance),"cos"), y:HyperMath.getOrbit(_high/2,(_high/2),(index*(curveAmount/_sides)+curveBalance),"sin")};
			if(args[0]){
				outputObject.x = args[0];
			}
			if(args[1]){
				outputObject.y = args[1];
			}
			return outputObject;
		}
		
		public function set wide(val:Number):void{
			_wide = Math.abs(val);
			resetPoints();
			redraw();
		}
		public function set high(val:Number):void{
			_high = Math.abs(val);
			resetPoints();
			redraw();
		}
		public function get wide():Number{
			return _wide;
		}
		public function get high():Number{
			return _high;
		}
	}
}