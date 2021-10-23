// ############################################################################
// Polygon - creates an instance of a polygon
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// CREATED ON: 10/18/2007
// ############################################################################
package com.tog.draw{
	import com.tog.utils.HyperMath;
	import flash.display.Sprite;
	public class Polygon extends Sprite{
		private var body:Sprite;
		public var corners:Array;
		public var fc:*;
		public var sc:Number;
		public var fa:Number;
		public var sa:Number;
		public var sw:Number;
		public var radius:Number;
		public var closedShape:Boolean;
		public function Polygon(...args){
			var defaultSize:Number = 72; 
			body = this;
			corners = args[0];
			fc = args[1];
			sc = args[2];
			fa = args[3];
			sa = args[4];
			sw = args[5];
			radius = args[6];
			if(!radius){
				radius = 0;
			}
			if(!corners){
				corners = [{x:0,y:0},{x:defaultSize,y:0},{x:defaultSize,y:defaultSize},{x:0,y:defaultSize}];
			}
			if(!fc){
				fc = 0;
			}
			if(!sc){
				sc = 0;
			}
			if(!fa){
				fa = 1;
			}
			if(!sa){
				sa = 0;
			}
			if(!sw){
				sw = 0;
			}
			if(!radius){
				radius = 0;
			}
			closedShape = true;
			redraw();
		}
		public function redraw():void{
			var anchorJump:Number = .75;
			body.graphics.clear();
			if(closedShape){
				if(fc is Number){
					body.graphics.beginFill(fc,fa);
				}
				else{
					body.graphics.beginGradientFill(fc.type,fc.colors,fc.alphas,fc.ratios,fc.matrix,fc.spreadMethod,fc.interpolationMethod,fc.focalPointRatio);
				}
			}
			body.graphics.lineStyle(sw,sc,sa);
			var curveEnd:Object = getCurveEnd(0,1);
			if(closedShape){
				body.graphics.moveTo(curveEnd.x,curveEnd.y);
			}
			else{
				body.graphics.moveTo(corners[0].x, corners[0].y);
			}
			var nextPoint:Number;
			var arch1:Object;
			var anchor1:Object;
			var curveEndOld:Object;
			var arch2:Object;
			var anchor2:Object;
			var archTop:Object;
			var halfCurve:Object;
			for(var i:Number=1;i<corners.length;i++){
				curveEndOld = curveEnd;
				curveEnd = getCurveEnd(i,i-1);
				halfCurve = {x:curveEndOld.x+((curveEnd.x-curveEndOld.x)/2), y:curveEndOld.y+((curveEnd.y-curveEndOld.y)/2)};
				body.graphics.curveTo(curveEndOld.x,curveEndOld.y,halfCurve.x,halfCurve.y);
				body.graphics.curveTo(curveEnd.x,curveEnd.y,curveEnd.x,curveEnd.y);
				if(i<corners.length-1){
					nextPoint = i+1;
				}
				else{
					nextPoint = 0;
				}
				arch1 = {x:corners[i].x+((curveEnd.x-corners[i].x)/2), y:corners[i].y+((curveEnd.y-corners[i].y)/2)};
				anchor1 = {x:corners[i].x+(((curveEnd.x-corners[i].x)/2)*anchorJump), y:corners[i].y+(((curveEnd.y-corners[i].y)/2)*anchorJump)};
				if(closedShape){
					curveEnd = getCurveEnd(i,nextPoint);
				}
				else{
					if(i == corners.length-1){
						curveEnd = {x:corners[i].x, y:corners[i].y};
					}
					else{
						curveEnd = getCurveEnd(i,nextPoint);
					}
				}
				arch2 = {x:corners[i].x+((curveEnd.x-corners[i].x)/2), y:corners[i].y+((curveEnd.y-corners[i].y)/2)};
				anchor2 = {x:corners[i].x+(((curveEnd.x-corners[i].x)/2)*anchorJump), y:corners[i].y+(((curveEnd.y-corners[i].y)/2)*anchorJump)};
				archTop = {x:arch1.x+((arch2.x-arch1.x)/2), y:arch1.y+((arch2.y-arch1.y)/2)};
				body.graphics.curveTo(arch1.x,arch1.y,archTop.x,archTop.y);
				body.graphics.curveTo(arch2.x,arch2.y,curveEnd.x,curveEnd.y);
			}
			if(closedShape){
				finalizeCurve(curveEnd);
			}
		}
		private function finalizeCurve(_ce:Object):void{
			var _curveEndOld:Object = _ce;
			var _curveEnd:Object = getCurveEnd(0,corners.length-1);
			var _halfCurve:Object = {x:_curveEndOld.x+((_curveEnd.x-_curveEndOld.x)/2), y:_curveEndOld.y+((_curveEnd.y-_curveEndOld.y)/2)};
			body.graphics.curveTo(_curveEndOld.x,_curveEndOld.y,_halfCurve.x,_halfCurve.y);
			body.graphics.curveTo(_curveEnd.x,_curveEnd.y,_curveEnd.x,_curveEnd.y);
			var _arch1:Object = {x:corners[0].x+((_curveEnd.x-corners[0].x)/2), y:corners[0].y+((_curveEnd.y-corners[0].y)/2)};
			_curveEnd = getCurveEnd(0,1);
			var _arch2:Object = {x:corners[0].x+((_curveEnd.x-corners[0].x)/2), y:corners[0].y+((_curveEnd.y-corners[0].y)/2)};
			var _archTop:Object = {x:_arch1.x+((_arch2.x-_arch1.x)/2), y:_arch1.y+((_arch2.y-_arch1.y)/2)};
			body.graphics.curveTo(_arch1.x,_arch1.y,_archTop.x,_archTop.y);
			body.graphics.curveTo(_arch2.x,_arch2.y,_curveEnd.x,_curveEnd.y);
			body.graphics.endFill();
		}
		private function getCurveEnd(num1:Number,num2:Number):Object{
			var tmpRad:Number = radius;
			var radStartDistance:Number = HyperMath.getDistance(corners[num1].x,corners[num1].y,corners[num2].x,corners[num2].y);
			if(tmpRad>radStartDistance/2){
				tmpRad = radStartDistance/2;
			}
			var radStartAngle:Number = HyperMath.getAngle(corners[num1].x,corners[num1].y,corners[num2].x,corners[num2].y);
			var radStart:Object = {x:null,y:null};
			radStart.x = HyperMath.getOrbit(corners[num1].x, tmpRad, radStartAngle, "cos");
			radStart.y = HyperMath.getOrbit(corners[num1].y, tmpRad, radStartAngle, "sin");
			return radStart;
		}
		public function set fillColor(val:*):void{
			fc = val;
			redraw();
		}
		public function set fillAlpha(val:Number):void{
			fa = val;
			redraw();
		}
		public function set strokeColor(val:Number):void{
			sc = val;
			redraw();
		}
		public function set strokeAlpha(val:Number):void{
			sa = val;
			redraw();
		}
		public function set strokeWeight(val:Number):void{
			sw = val;
			redraw();
		}
		public function set cornerRadius(val:Number):void{
			radius = val;
			redraw();
		}
		public function set cornerPoints(val:Array):void{
			corners = val;
			redraw();
		}
		
		public function get fillColor():*{
			return fc;
		}
		public function get fillAlpha():Number{
			return fa;
		}
		public function get strokeColor():Number{
			return sc;
		}
		public function get strokeAlpha():Number{
			return sa;
		}
		public function get strokeWeight():Number{
			return sw;
		}
		public function get cornerRadius():Number{
			return radius;
		}
		public function get cornerPoints():Array{
			return corners;
		}
	}
}