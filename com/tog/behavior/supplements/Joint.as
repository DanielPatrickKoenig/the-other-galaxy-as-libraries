/*
########################################################################
Joint creates the main point in a BezierCurve point set
Author: Dan Koenig
Date: 3/1/08
########################################################################
//*/
package com.tog.behavior.supplements{
	import flash.display.Sprite;
	//import flash.display.DisplayObjectContainer;
	import com.tog.draw.Equilateral;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.tog.behavior.supplements.AnchorPoint;
	public class Joint extends Sprite{
		public var drag:Boolean;
		private var targScope:*;
		public var anchoring:Boolean;
		public var pairs:Object;
		public var id:int;
		public var anchors:Array;
		public var distList:Array;
		public function Joint(_id:int, _caller:*){
			id = _id;
			targScope = _caller;
			anchors = new Array();
			var size:Number = 6;
			var body:Equilateral = new Equilateral();
			addChild(body);
			body.diameter = size;
			this.addEventListener(MouseEvent.MOUSE_DOWN,grabPoint);
			this.addEventListener(MouseEvent.MOUSE_UP,releasePoint);
			this.addEventListener(MouseEvent.MOUSE_OVER,openUp);
			this.addEventListener(MouseEvent.MOUSE_OUT,closeUp);
			
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
			if(targScope.mode==1){
				drag = true;
				distList = new Array();
				for(var i:Number = 0;i<anchors.length;i++){
					distList.push({x:anchors[i].x-this.x, y:anchors[i].y-this.y});
				}
				this.addEventListener(Event.ENTER_FRAME,dragPoint);
				targScope.setSelected(id);
			}
		}
		//releasePoint() stops dragging point
		private function releasePoint(e:MouseEvent):void{
			endDrag();
		}
		//endDrag() stops dragging point
		public function endDrag():void{
			drag = false;
			this.removeEventListener(Event.ENTER_FRAME,dragPoint);
		}
		//dragPoint() facilitates the dragging of point
		private function dragPoint(e:Event):void{
			if(drag){
				this.x = targScope.mouseX;
				this.y = targScope.mouseY;
				for(var i:Number = 0;i<anchors.length;i++){
					anchors[i].x = this.x+distList[i].x;
					anchors[i].y = this.y+distList[i].y;
				}
				targScope.link(id);
			}
		}
		
	}
}