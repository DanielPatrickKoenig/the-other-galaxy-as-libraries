/*
########################################################################
BesierCurve creates a dynamically drawn shape based on line-ending points and anchor points that can be moved to edit the dimensions of the shape
Author: Dan Koenig
Date: 3/1/08
########################################################################
//*/
package com.tog.draw{
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import com.tog.utils.HyperMath;
	import com.tog.utils.DisplayToolKit;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.tog.behavior.supplements.PointSet;
	public class BezierCurve extends Sprite{
		public var pointSets:Array;
		public var open:Boolean;
		public var _mode:Number;
		public var bg:Sprite;
		
		private var offset:Object;
		private var line:Sprite;
		private var redrawNum:int;
		private var scope:DisplayObjectContainer;
		
		public var fc:Number;
		public var sc:Number;
		public var fa:Number;
		public var sa:Number;
		public var sw:Number;
		private var connector:Sprite;
		public function BezierCurve(...args){
			bg = new Sprite();
			scope = this.parent;
			fc = args[0];
			sc = args[1];
			fa = args[2];
			sa = args[3];
			sw = args[4];
			pointSets = args[5];
			if(!pointSets){
				pointSets = new Array();
			}
			if(!fc){
				fc = 0;
			}
			if(!sc){
				sc = 0;
			}
			if(!fa){
				fa = 0;
			}
			if(!sa){
				sa = 1;
			}
			if(!sw){
				sw = 0;
			}
			init();
		}
		//init() creates shape for the first time
		public function init():void{
			//*
			//create background for shape
			mode = -2;
			bg.graphics.beginFill(0xFFFFFF,0);
			var top:Number = -5000;
			var bottom:Number = 5000;
			var left:Number = -5000;
			var right:Number = 5000;
			bg.graphics.moveTo(left,top);
			bg.graphics.lineTo(right,top);
			bg.graphics.lineTo(right,bottom);
			bg.graphics.lineTo(left,bottom);
			bg.graphics.endFill();
			addChild(bg);
			//*/
			line = new Sprite();
			addChild(line);
			
			connector = new Sprite();
			addChild(connector);
		}
		//hideBG() disables shape editing
		public function hideBG():void{
			//removeChild(bg);
			bg.visible = false;
			//bg.scaleX = Math.random();
		}
		//showBG() enables shape editing
		public function showBG():void{
			//removeChild(bg);
			bg.visible = true;
			//bg.scaleX = Math.random();
		}
		//deactivateAnchors() stops a target set of anchors from moving with mouse
		public function deactivateAnchors(n:int):void{
			pointSets[n].anchors[0].endDrag();
			pointSets[n].anchors[1].endDrag();
		}
		//addPoint() adds a point in to the curve
		public function addPoint(_x:Number,_y:Number,active:Boolean):void{
			var distanceCheck:Number;
			var endingCheck:Boolean;
			if(pointSets[0]){
				distanceCheck = HyperMath.getDistance(_x,_y,pointSets[0].joint.x,pointSets[0].joint.y);
				endingCheck = distanceCheck<20 && pointSets.length>2;
			}
			else{
				endingCheck = false;
			}
			if(!endingCheck){
				var ps:PointSet = new PointSet(pointSets.length,this, _x, _y);
				pointSets.push(ps);
			}
			
			if(!active){
				deactivateAnchors(pointSets.length-1);
			}
			if(endingCheck){
				//this.fillAlpha = .1;
				this.open = false;
			}
		}
		//*
		//activateDrag() turns on the ability to drag shapes around
		private function activateDrag():void{
			if(_mode == 0 || _mode == 1){
				//if(line){
					line.addEventListener(MouseEvent.MOUSE_DOWN, dragShape);
					line.addEventListener(MouseEvent.MOUSE_UP, dropShape);
					//deselectSiblings();
				//}
			}
			
			else{
				if(line){
					line.removeEventListener(MouseEvent.MOUSE_DOWN, dragShape);
					line.removeEventListener(MouseEvent.MOUSE_UP, dropShape);
				}
			}
		}
		//dragShape() starts the process of dragging a shape
		private function dragShape(e:MouseEvent):void{
			if(line){
				if(_mode == 0){
					offset = {x:mouseX,y:mouseY};
					addEventListener(Event.ENTER_FRAME, moveShape);
				}
				else{
					deselectSiblings();
					selectAll();
				}
			}
		}
		//moveShape() moves shape around with mouse
		public function moveShape(e:Event):void{
			this.x = this.parent.mouseX-offset.x;
			this.y = this.parent.mouseY-offset.y;
			//redraw();
		}
		//dropShape() ends the process of dragging a shape
		public function dropShape(e:Event):void{
			if(line){
				var siblings:Array = getSiblings();
				for(var i:int = 0;i<siblings.length;i++){
					siblings[i].removeEventListener(Event.ENTER_FRAME, siblings[i].moveShape);
					siblings[i].dropAllPoints();
					if(_mode == 1){
						siblings[i].redraw();
					}
				}
			}
		}
		//getSiblings() returns an array of all BezierCurves in the same scope as this one
		private function getSiblings():Array{
			return DisplayToolKit.getChildren(this.parent);
		}
		//deselectSiblings() deselects all BezierCurve objects
		private function deselectSiblings():void{
			var siblings:Array = getSiblings();
			for(var i:int = 0;i<siblings.length;i++){
				siblings[i].setUnSelected();
			}
			
		}
		//*/
		//startDelayedRedraw() used for getters and setters
		private function startDelayedRedraw():void{
			redrawNum = 0;
			addEventListener(Event.ENTER_FRAME, delayedRedraw);
		}
		//delayedRedraw() facilitates the alteration of multiple properties simultaniously
		private function delayedRedraw(e:Event):void{
			redrawNum++;
			if(redrawNum>2){
				redraw();
				removeEventListener(Event.ENTER_FRAME, delayedRedraw);
			}
		}
		//redraw() renders shape
		public function redraw():void{
			var pointPairs:Array = new Array();
			line.graphics.clear();
			if(fa>0){
				line.graphics.beginFill(fc,fa);
			}
			line.graphics.lineStyle(sw,sc,sa);
			line.graphics.moveTo(pointSets[0].joint.x,pointSets[0].joint.y);
			for(var i:Number = 0; i<pointSets.length;i++){
				var apex1:Object = pointSets[i].getApex(0);
				var apex2:Object = pointSets[i].getApex(1);
				pointPairs.push({x1:apex1.x,y1:apex1.y,x2:apex2.x,y2:apex2.y});
			}
			for(var j:Number = 1; j<pointPairs.length;j++){
				var pointObject:Object = {x:pointPairs[j-1].x2+((pointPairs[j].x1-pointPairs[j-1].x2)/2),y:pointPairs[j-1].y2+((pointPairs[j].y1-pointPairs[j-1].y2)/2)};
				line.graphics.curveTo(pointPairs[j-1].x2,pointPairs[j-1].y2,pointObject.x,pointObject.y);
				line.graphics.curveTo(pointPairs[j].x1,pointPairs[j].y1,pointSets[j].joint.x,pointSets[j].joint.y);
			}
			if(!open && (mode == -2 || mode == 1)){
				var lastPointVal:int = pointPairs.length-1;
				var firstPointVal:int = 0;
				var closePoint:Object = {x:pointPairs[lastPointVal].x2+((pointPairs[firstPointVal].x1-pointPairs[lastPointVal].x2)/2),y:pointPairs[lastPointVal].y2+((pointPairs[firstPointVal].y1-pointPairs[lastPointVal].y2)/2)};
				line.graphics.curveTo(pointPairs[lastPointVal].x2,pointPairs[lastPointVal].y2,closePoint.x,closePoint.y);
				line.graphics.curveTo(pointPairs[firstPointVal].x1,pointPairs[firstPointVal].y1,pointSets[firstPointVal].joint.x,pointSets[firstPointVal].joint.y);
				if(mode == -2){
					setSelected(0);
				}
			}
		}
		//selectAll() highlights all points in shape
		public function selectAll():void{
			for(var i:Number = 0; i<pointSets.length;i++){
				pointSets[i].mode = 0;
			}
		}
		//setSelected() highlights target point
		public function setSelected(n:int):void{
			for(var i:Number = 0; i<pointSets.length;i++){
				pointSets[i].mode = 0;
				if(i == n){
					pointSets[i].mode = 1;
				}
			}
			link(n);
		}
		//setUnSelected() unhighlights all points in shape
		public function setUnSelected():void{
			for(var i:Number = 0; i<pointSets.length;i++){
				pointSets[i].mode = -1;
			}
			connector.graphics.clear();
		}
		//dropAllPoints() terminates the manipulation of all points
		public function dropAllPoints():void{
			for(var i:Number = 0; i<pointSets.length;i++){
				pointSets[i].endDrag();
			}
		}
		//link() creates line between anchor points
		public function link(n:int):void{
			connector.graphics.clear();
			connector.graphics.lineStyle(0,0x000000,.3);
			connector.graphics.moveTo(pointSets[n].anchors[0].x,pointSets[n].anchors[0].y);
			connector.graphics.lineTo(pointSets[n].joint.x,pointSets[n].joint.y);
			connector.graphics.lineTo(pointSets[n].anchors[1].x,pointSets[n].anchors[1].y);
		}
		//dropAllPoints() terminates the manipulation of all points and anchor points
		public function releaseAll():void{
			for(var i:Number = 0; i<pointSets.length;i++){
				pointSets[i].releaseAll();
			}
		}
		
		public function set fillColor(val:Number):void{
			fc = val;
			startDelayedRedraw();
			//redraw();
		}
		public function set fillAlpha(val:Number):void{
			fa = val;
			startDelayedRedraw();
			//redraw();
		}
		public function set strokeColor(val:Number):void{
			sc = val;
			startDelayedRedraw();
			//redraw();
		}
		public function set strokeAlpha(val:Number):void{
			sa = val;
			startDelayedRedraw();
			//redraw();
		}
		public function set strokeWeight(val:Number):void{
			sw = val;
			startDelayedRedraw();
			//redraw();
		}
		public function set points(val:Array):void{
			pointSets = val;
			startDelayedRedraw();
			//redraw();
		}
		public function set mode(val:Number):void{
			_mode = val;
			activateDrag();
		}
		public function get fillColor():Number{
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
		public function get points():Array{
			return pointSets;
		}
		public function get mode():Number{
			return _mode;
		}
	}
}