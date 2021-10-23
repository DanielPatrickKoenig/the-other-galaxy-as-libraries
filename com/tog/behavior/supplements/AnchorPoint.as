/*
########################################################################
AnchorPoint creates the an anchor point in a BezierCurve point set
Author: Dan Koenig
Date: 3/1/08
########################################################################
//*/
package com.tog.behavior.supplements{
	import flash.display.Sprite;
	//import flash.display.*;
	import com.tog.draw.Ellipse;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.tog.behavior.supplements.Joint;
	public class AnchorPoint extends Sprite{
		public var drag:Boolean;
		private var targScope:*;
		public var anchoring:Boolean;
		public var pairs:Object;
		public var id:int;
		private var sisterPoint:AnchorPoint;
		private var myJoint:Joint;
		//private var connector:Sprite;
		public function AnchorPoint(_id:int, _caller:*){
			id = _id;
			targScope = _caller;
			drag = true;
			this.addEventListener(Event.ENTER_FRAME,dragPoint);
			var size:Number = 4;
			var body:Ellipse = new Ellipse();
			addChild(body);
			//connector = new Sprite();
			//addChild(connector);
			body.wide = size;
			body.high = size;
			body.addEventListener(MouseEvent.MOUSE_DOWN,grabPoint);
			body.addEventListener(MouseEvent.MOUSE_UP,releasePoint);
			body.addEventListener(MouseEvent.MOUSE_OVER,openUp);
			body.addEventListener(MouseEvent.MOUSE_OUT,closeUp);
			
			
			
			//scope[id] = scope.createEmptyMovieClip(id,scope.getNextHighestDepth());
			//scope[id]._x = x;
			//scope[id]._y = y;
		}
		private function openUp(e:MouseEvent):void{
			//targScope.open = false;
		}
		private function closeUp(e:MouseEvent):void{
			//targScope.open = true;
		}
		//grabPoint() starts dragging point
		private function grabPoint(e:MouseEvent):void{
			if(!targScope.mode==0){
				drag = true;
				this.addEventListener(Event.ENTER_FRAME,dragPoint);
			}
		}
		//releasePoint() stops dragging point
		private function releasePoint(e:MouseEvent):void{
			endDrag();
		}
		//dragPoint() facilitates the dragging of point
		private function dragPoint(e:Event):void{
			if(drag){
				this.x = targScope.mouseX;
				this.y = targScope.mouseY;
				var dist:Object = {x:joint.x-this.x, y:joint.y-this.y};
				sister.x = joint.x+dist.x;
				sister.y = joint.y+dist.y;
				targScope.link(id);
				//link();
				//this._parent[this.pairs.a]._x =  this._parent[this.pairs.p]._x+dist.x;
				//this._parent[this.pairs.a]._y =  this._parent[this.pairs.p]._y+dist.y;
			}
		}
		//sister() sets the other anchor in set
		public function set sister(val:AnchorPoint):void{
			sisterPoint = val;
			if(!val.sister){
				val.sister = this;
				val.sister.rotation = 180;
			}
		}
		//sister() returns other anchor in set
		public function get sister():AnchorPoint{
			return sisterPoint;
		}
		//joint() sets the joint object in set
		public function set joint(val:Joint):void{
			val.anchors.push(this);
			myJoint = val;
		}
		//joint() returns the joint object in set
		public function get joint():Joint{
			return myJoint;
		}
		//endPoint() stops dragging point
		public function endDrag():void{
			drag = false;
			this.removeEventListener(Event.ENTER_FRAME,dragPoint);
		}
	}
}