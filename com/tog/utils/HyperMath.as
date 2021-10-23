// ############################################################################
// HyperMath - math functoins
// ============================================================================
// CREATED BY:	Dan Koenig
//
// ############################################################################
package com.tog.utils{
	public class HyperMath{
		//#########################################################################################//
		////////////// RETURNS THE DISTANCE BETWEEN TWO POINTS - (Pythagorean Theorem) //////////////
		/////////////////////////////////////////////////////////////////////////////////////////////
		public static function getDistance(_num1:Number, _num2:Number, _num3:Number, _num4:Number):Number{
			var x1:Number = _num1;
			var y1:Number = _num2;
			var x2:Number = _num3;
			var y2:Number = _num4;
			var distx:Number = x2-x1;
			var disty:Number = y2-y1;
			return Math.sqrt(Math.pow(distx,2)+Math.pow(disty,2));
		}
		//#########################################################################################//
		///////////////// RETURNS THE ANGLE OF A STREIGHT LINE BETWEEN TWO POINTS ///////////////////
		/////////////////////////////////////////////////////////////////////////////////////////////
		public static function getAngle(_num1:Number, _num2:Number, _num3:Number, _num4:Number):Number{
			var x1:Number = _num1;
			var y1:Number = _num2;
			var x2:Number = _num3;
			var y2:Number = _num4;
			//triangulate
			var distx:Number = x2-x1;
			var disty:Number = y2-y1;
			var masterdist:Number = getDistance(x1, y1, x2, y2);
			//calculate anglex
			var primary_anglex:Number = distx/masterdist;
			var anglex:Number = Math.asin(primary_anglex)*180/Math.PI;
			//calculate angley
			var primary_angley:Number = disty/masterdist;
			var angley:Number = Math.asin(primary_angley)*180/Math.PI;
			//angle execution
			var resultVal:Number;
			if (disty<0) {
				resultVal = anglex;
			}
			else if (disty>=0 && distx>=0) {
				resultVal = angley+90;
			}
			else if (disty>=0 && distx<0) {
				resultVal = (angley*-1)-90;
			}
			return resultVal;
		}
		
		//#########################################################################################//
		//// RETURNS THE LOCATION CORROSPONDING WITH A SPECIFIED LOCATION, ANGLE AND DISTANCE ///////
		/////////////////////////////////////////////////////////////////////////////////////////////
		//*
		public static function getOrbit(_num1:Number, _num2:Number, _num3:Number, orbitType:String):Number{
			var theCent:Number = _num1;
			var radius:Number = _num2;
			var angle:Number = _num3-90;
			var ot:String = orbitType;
			var resultVal:Number;
			if(ot == "cos"){
				resultVal = theCent+(Math.cos((angle)*(Math.PI/180))*radius);
			}
			if(ot == "sin"){
				resultVal = theCent+(Math.sin((angle)*(Math.PI/180))*radius);
			}
			return resultVal;
		}
		//*/
		public static function plotToCurve(_startPoint:Object,_endPoint:Object,_anchorPoint:Object,_ratio:Number):Object{
			var plotX:Number = plotToLine(_startPoint.x,_endPoint.x,_anchorPoint.x,_ratio);
			var plotY:Number = plotToLine(_startPoint.y,_endPoint.y,_anchorPoint.y,_ratio);
			var curvePoint:Object = {x:plotX, y:plotY};
			return curvePoint;
		}
		public static function plotToLine(_startPoint:Number,_endPoint:Number,_anchorPoint:Number,_ratio:Number):Number{
			var _centerPoint:Number = _startPoint+((_endPoint-_startPoint)*_ratio);
			var _curveRat:Number;
			var _realRat:Number;
			var _pointA:Number;
			var _pointB:Number;
			
			if(_ratio<=.5){
				_curveRat = 1-_ratio;
				_realRat = _ratio*2;
				_pointA = _startPoint;
				_pointB = _anchorPoint;
			}
			else{
				_curveRat = 1-(1-_ratio);
				_realRat = _ratio;
				_pointA = _anchorPoint+(_anchorPoint-_endPoint);
				_pointB = _endPoint;
			}
			var basePoint:Number = _pointA+((_pointB-_pointA)*_realRat);
			//trace(_curveRat);
			var curvePoint:Number = _centerPoint+((basePoint-_centerPoint)*_curveRat);
			return curvePoint;
		}
		
		public static function pointPath(_points:Array):Array{
			var breaks:Array = new Array();
			var totalDistance:Number = 0;;
			breaks.push({x:_points[0].x,y:_points[0].y,dist:totalDistance});
			for(var i:Number = 1;i<_points.length;i++){
				var dist:Number = getDistance(_points[i].x,_points[i].y,_points[i-1].x,_points[i-1].y);
				totalDistance+=dist;
				breaks.push({x:_points[i].x,y:_points[i].y,dist:totalDistance});
			}
			return breaks;
		}
		
		public static function plotToPath(_ratio:Number,_points:Array):Object{
			var _path:Array = pointPath(_points);
			var totalDistance:Number = _path[_path.length-1].dist;
			var _fullRat:Number = totalDistance*_ratio;
			var _section:Number = -1;
			for(var i:Number = 1;i<_path.length;i++){
				if(_fullRat <= _path[i].dist && _fullRat > _path[i-1].dist){
					_section = i-1;
				}
			}
			var cData:Object = _path[_section];
			var nData:Object = _path[Number(_section+1)];
			var base:Number = nData.dist-cData.dist;
			var diff:Number = _fullRat-cData.dist;
			var _newRat:Number = diff/base;
			var newPoint:Object = {x:cData.x+((nData.x-cData.x)*_newRat), y:cData.y+((nData.y-cData.y)*_newRat)};
			//trace(newPoint.x);
			return newPoint;
		}
		
		public static function plotToCurvedPath(_ratio:Number,_points:Array,_anchors:Array):Object{
			
			var newPoint:Object;
			if(_ratio == 0){
				newPoint = {x:_points[0].x, y:_points[0].y};
			}
			else{
				var _path:Array = pointPath(_points);
				var totalDistance:Number = _path[_path.length-1].dist;
				var _fullRat:Number = totalDistance*_ratio;
				var _section:Number = -1;
				for(var i:Number = 1;i<_path.length;i++){
					if(_fullRat <= _path[i].dist && _fullRat > _path[i-1].dist){
						_section = i-1;
					}
				}
				var cData:Object = _path[_section];
				var nData:Object = _path[Number(_section+1)];
				var base:Number = nData.dist-cData.dist;
				var diff:Number = _fullRat-cData.dist;
				var _newRat:Number = diff/base;
				var currentAnchor:Object = _anchors[_section];
				
				//var newPoint:Object = {x:cData.x+((nData.x-cData.x)*_newRat), y:cData.y+((nData.y-cData.y)*_newRat)};
				newPoint = plotToCurve(cData,nData,currentAnchor,_newRat);
				if(_section == -1){
					newPoint = {x:_points[_points.length-1].x, y:_points[_points.length-1].y};
				}
			}
			//trace(newPoint.x);
			return newPoint;
		}
		
		public static function plotToWave(_startPoint:Object,_path:Array,_ratio:Number):Object{
			var _fullRat:Number = _ratio*_path.length;
			var _newRat:Number = Math.floor(_fullRat);
			var section:Number = -1;
			for(var i:Number=0;i<_path.length;i++){
				if(i == _newRat){
					section = i;
				}
			}
			//trace(section);
			var starter:Object;
			var masterRatio:Number;
			if(section == 0){
				starter = _startPoint;
				masterRatio = _fullRat-_newRat;
			}
			else{
				starter = {x:_path[section-1].cX,y:_path[section-1].cY};
				masterRatio = _fullRat-_newRat;
			}
			var tempSec:Number = section;
			if(section<0){
				tempSec = _path.length-1;
			}
			var anchor:Object =  {x:_path[tempSec].aX,y:_path[tempSec].aY};
			var ender:Object =  {x:_path[tempSec].cX,y:_path[tempSec].cY};
			
			//trace(masterRatio);
			var mark:Object = plotToCurve(starter,ender,anchor,masterRatio);
			if(section < 0){
				//trace("finished");
				mark = {x:ender.x, y:ender.y};
			}
			return mark;
		}
	}
}