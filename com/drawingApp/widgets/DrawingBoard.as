/*
########################################################################
DrawingBoard a platform for dynamic drawing
Author: Dan Koenig

########################################################################
//*/
package com.drawingApp.widgets{
	import flash.display.Sprite;
	import com.tog.behavior.Pen;
	import com.tog.draw.Box;
	import com.tog.composition.Column;
	import com.tog.composition.Layout;
	import flash.events.MouseEvent;
	import com.tog.utils.DisplayToolKit;
	//import com.draw.BezierCurve;
	public class DrawingBoard extends Sprite{
		private var artBoard:Sprite;
		private var toolList:Array;
		public function DrawingBoard(){
			artBoard = new Sprite();
			addChild(artBoard);
			/*
			toolList = new Array();
			toolList.push(addShape);
			toolList.push(moveShape);
			toolList.push(editShape);
			var tools:Sprite = createTools();
			*/
			//addShape();
		}
		public function addShape():void{
			cleanUp();
			var _pen:Pen = new Pen();
			_pen.activatePoints();
			artBoard.addChild(_pen);
			//var tools:
			_pen.strokeWeight = 3;
			_pen.fillAlpha = .5;
			_pen.strokeColor = 0xcc0000;
		}
		public function moveShape():void{
			setModes(0);
			cleanUp();
			/*
			var _pen:Pen = new Pen();
			artBoard.addChild(_pen);
			//var tools:
			_pen.strokeWeight = 3;
			_pen.fillAlpha = .5;
			_pen.strokeColor = 0xcc0000;
			//*/
		}
		public function editShape():void{
			setModes(1);
			cleanUp();
			/*
			var _pen:Pen = new Pen();
			artBoard.addChild(_pen);
			//var tools:
			_pen.strokeWeight = 3;
			_pen.fillAlpha = .5;
			_pen.strokeColor = 0xcc0000;
			//*/
		}
		/*
		private function createTools():Sprite{
			var _tools:Sprite = new Sprite();
			addChild(_tools);
			for(var i:Number = 0;i<toolList.length;i++){
				var box:Box = new Box();
				_tools.addChild(box);
				box.addEventListener(MouseEvent.MOUSE_DOWN, toolList[i]);
			}
			var layout:Layout = new Layout(_tools,new Column());
			return _tools;
			//pen.strokeWeight = 8;
		}
		*/
		private function cleanUp():void{
			var children:Array = DisplayToolKit.getChildren(artBoard);
			for(var i:Number = 0;i<children.length;i++){
				if(children[i].pointSets.length < 2){
					artBoard.removeChild(children[i]);
				}
			}
		}
		private function setModes(_num:Number):void{
			var children:Array = DisplayToolKit.getChildren(artBoard);
			for(var i:Number = 0;i<children.length;i++){
				children[i].mode = _num;
				children[i].open = false;
				children[i].hideBG();
				if(_num == -2){
					children[i].showBG();
				}
				else{
					children[i].deactivatePoints();
				}
				if(_num == 0 || _num == -1){
					children[i].setUnSelected();
				}
				if(_num == 1){
					children[i].activatePoints();
				}
			}
		}

		
	}
}