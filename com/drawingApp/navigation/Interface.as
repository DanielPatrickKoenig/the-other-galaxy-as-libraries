/*
########################################################################
Menu a basic drawing application
Author: Dan Koenig

########################################################################
//*/
package com.drawingApp.navigation{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.tog.utils.HyperXML;
	import com.tog.navigation.XHMLDrivenMenu;
	import flash.display.Sprite;
	import com.tog.composition.Layout;
	import com.tog.composition.Column;
	import com.tog.draw.Box;
	
	import flash.events.MouseEvent;
	
	import com.drawingApp.widgets.DrawingBoard;
	import com.tog.behavior.Pen;
	
	public class Interface extends XHMLDrivenMenu{
		private var tf:TextField;
		private var files:Array;
		private var items:Array;
		private var drawingBoard:DrawingBoard;
		public function Interface(_src:String){
			super(_src);
			drawingBoard = new DrawingBoard();
			addChild(drawingBoard);
		}
		
		public override function onLoaded(_data:XML):void{
			
			var menuItems:Array = HyperXML.getNodesByAttribute(_data, "tool", "kind");
			
			var menu:Sprite = drawMenu(menuItems);
			
			var layout:Layout = new Layout(menu,new Column());
			
			
		}
		public function drawShape(e:MouseEvent):void{
			drawingBoard.addShape();
		}
		public function moveShape(e:MouseEvent):void{
			drawingBoard.moveShape();
		}
		public function editShape(e:MouseEvent):void{
			drawingBoard.editShape();
		}
		public function drawMenu(_items:Array):Sprite{
			var menu:Sprite = new Sprite();
			addChild(menu);
			for(var i:Number = 0;i<_items.length;i++){
				var item:Sprite = new Sprite();
				menu.addChild(item);
				
				var box:Box = new Box();
				item.addChild(box);
				
				var tf:TextField = new TextField();
				item.addChild(tf);
				tf.autoSize = "left";
				tf.text = _items[i].toString();
				tf.selectable = false;
				box.wide = tf.width;
				box.high = tf.height;
				box.fillColor = 0xCCFFFF;
				box.cornerRadius = 4;
				
				item.addEventListener(MouseEvent.MOUSE_DOWN, this[_items[i].toString()+"Shape"]);
				
				
				//item.y = i*30;
			}
			return menu;
			
		}
	}
}