/*
########################################################################
PointSet creates a set of 3 points along a BezierCurve (two anchor points and one main point)
Author: Dan Koenig
Date: 3/1/08
########################################################################
//*/
package com.tog.behavior.supplements{
	//import flash.display.DisplayObjectContainer;
	import com.tog.draw.Ellipse;
	import com.tog.behavior.supplements.AnchorPoint;
	import com.tog.behavior.supplements.Joint;
	
	public class PointSet{
		public var joint:Joint;
		public var anchors:Array;
		private var caller:*;
		private var setMode:Number;
		private var id:int;
		public function PointSet(_id:int,_caller:*, _x:Number, _y:Number){
			id = _id;
			caller = _caller;
			//mode = -1;
			joint = new Joint(id, caller);
			caller.addChild(joint);
			joint.x = _x;
			joint.y = _y;
			
			
			anchors = new Array();
			anchors[0] = createAnchor(_x,_y);
			anchors[1] = createAnchor(_x,_y);
			anchors[0].sister = anchors[1];
			anchors[0].joint = joint;
			anchors[1].joint = joint;
		}
		//releaseAll() drops all points in set
		public function releaseAll():void{
			joint.drag = false;
			anchors[0].drag = false;
			anchors[1].drag = false;
		}
		//createAnchor() returns an anchor point for set
		public function createAnchor(_x:Number, _y:Number):AnchorPoint{
			var ap:AnchorPoint = new AnchorPoint(id, caller);
			caller.addChild(ap);
			ap.x = _x;
			ap.y = _y;
			return ap;
		}
		//getApex() returns the control point for a given curve
		public function getApex(n:int):Object{
			var anc:AnchorPoint = anchors[n];
			var dist:Object = {x:joint.x-anc.x, y:joint.y-anc.y};
			var outPut:Object = {x:anc.x+(dist.x/4), y:anc.y+(dist.y/4)};
			return outPut;
		}
		//endDrag() drops all points in set
		public function endDrag():void{
			joint.endDrag();
			anchors[0].endDrag();
			anchors[1].endDrag();
		}
	
		public function set mode(val:Number):void{
			setMode = val;
			if(setMode > 0){
				anchors[0].visible = true;
				anchors[1].visible = true;
				joint.visible = true;
			}
			if(setMode == 0){
				anchors[0].visible = false;
				anchors[1].visible = false;
				joint.visible = true;
			}
			if(setMode < 0){
				anchors[0].visible = false;
				anchors[1].visible = false;
				joint.visible = false;
			}
		}
		public function get mode():Number{
			return setMode;
		}
	}
}