/*
########################################################################
Pen creates a dynamically drawn shape based on line-ending points and anchor points that can be moved to edit the dimensions of the shape
Author: Dan Koenig
Date: 3/1/08
########################################################################
//*/
package com.tog.behavior{
	import flash.events.MouseEvent;
	import com.tog.draw.BezierCurve;
	import com.tog.behavior.Editable;
	public class Pen extends BezierCurve implements Editable{
		//private var pointSets:Array;
		//public var open:Boolean;
		//private var line:Sprite;
		public function Pen(...args){
			open = true;
			init();
			//activatePoints();
		}
		//activatePoints() makes shape editable
		public function activatePoints():void{
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		//deactivatePoints() makes shape uneditable
		public function deactivatePoints():void{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		//makePoint() inserts a new point on curve
		public function makePoint():void{
			addPoint(mouseX, mouseY, true);
			redraw();
			setSelected(pointSets.length-1);
		}
		public function onMouseDown(e:MouseEvent):void{
			if(open){
				makePoint();
			}
			else if(mode == -2){
				setUnSelected();
				var pen:Pen = new Pen();
				pen.fillColor = this.fillColor;
				pen.strokeColor = this.strokeColor;
				pen.fillAlpha = this.fillAlpha;
				pen.strokeAlpha = this.strokeAlpha;
				pen.strokeWeight = this.strokeWeight;
				this.parent.addChild(pen);
				pen.makePoint();
				pen.activatePoints();
			}
		}
		public function onMouseUp(e:MouseEvent):void{
			deactivateAnchors(pointSets.length-1);
			releaseAll();
			throw(new Error("this is an error"));
		}
		public function onMouseMove(e:MouseEvent):void{
			redraw();
		}
	}
	
}