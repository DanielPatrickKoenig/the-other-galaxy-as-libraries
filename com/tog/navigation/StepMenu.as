package com.tog.navigation{
	import flash.display.Sprite;
	import com.tog.utils.ProgressiveLoaderAS3;
	import com.tog.utils.DisplayToolKit;
	import com.tog.composition.Layout;
	import com.tog.composition.Stack;
	import com.tog.navigation.RectangularButton;
	import com.tog.draw.Box;
	import com.tog.events.RecursionEvent;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;
	import com.tog.navigation.InteractiveSystem;
	public class DisplayHierarchyMenu extends Sprite implements InteractiveSystem{
		private var container:Sprite;
		//private var marker:Sprite;
		private var marker:Box;
		public function DisplayHierarchyMenu(){
			var file:String = "BezTest2.swf";
			container = new Sprite();
			container.y = 100;
			this.addChild(container);
			marker = new Box();
			this.addChild(marker);
			//marker.alpha = .5;
			marker.fillAlpha = 0;
			marker.strokeAlpha = 1;
			marker.strokeWeight = 0;
			marker.strokeColor = 0xCC0000;
			marker.cornerRadius = 0;
			this.addEventListener(RecursionEvent.COMPLETE, targetLoaded);
			var pg:ProgressiveLoaderAS3 = new ProgressiveLoaderAS3([{asset:file, displayObject:container}], this);
		}
		
		private function targetLoaded(e:RecursionEvent):void{
			//container.rotation = 30;
			
			var mainMenu:Sprite = createMenu(this,container);
			
		}
		
		public function clickItem(e:MouseEvent):void{
			var _rb:RectangularButton = RectangularButton(e.target);
			var currentMode:int = _rb.getMode();
			if(currentMode>0){
				_rb.setMode(0);
				DisplayToolKit.removeChildren(_rb.subMenu);
				Layout.updateAll();
			}
			else{
				_rb.setMode(1);
				if(_rb.partner is DisplayObjectContainer){
					var menuAddition:Sprite = createMenu(_rb.subMenu, _rb.partner);
				}
				Layout.updateAll();
			}
			
		}
		
		public function rolloverItem(e:MouseEvent):void{
			var _rb:* = RectangularButton(e.target).partner;
			var pos:Object = _rb.getBounds(this);
			marker.visible = true;
			marker.x = pos.x;
			marker.y = pos.y;
			marker.wide = pos.width;
			marker.high = pos.height;
			marker.cornerRadius = 0;
			
		}
		
		public function rolloutItem(e:MouseEvent):void{
			var _rb:* = RectangularButton(e.target).partner;
			marker.visible = false;
		}
		
		private function createMenu(_owner:DisplayObjectContainer,_target:*):Sprite{
			var menuContainer:Sprite = new Sprite();
			_owner.addChild(menuContainer);
			var menu:Sprite = new Sprite();
			var childList:Array = new Array();
			menuContainer.addChild(menu);
			menuContainer.x = 10;
			//menuContainer.y = 10;
			
			var children:Array = getData(_target);
			
			for(var i:int = 0;i<children.length;i++){
				childList[i] = new Sprite();
				//childList[i].x = 30;
				
				menu.addChild(childList[i]);
				var subMenu:Sprite = new Sprite();
				var box:RectangularButton = createMenuItem(childList[i], children[i]);
				
				box.subMenu = subMenu;
				
				box.addEventListener(MouseEvent.MOUSE_DOWN, clickItem);
				box.addEventListener(MouseEvent.MOUSE_OVER, rolloverItem);
				box.addEventListener(MouseEvent.MOUSE_OUT, rolloutItem);
				
				childList[i].addChild(subMenu);
				var childLayout:Layout = new Layout(childList[i],new Stack());
				
			}
			var menuLayout:Layout = new Layout(menu,new Stack());
			//var menuContainerLayout:Layout = new Layout(menuContainer,new Column());
			//Layout.updateAll();
			return menuContainer;
		}
		public function createMenuItem(_container:Sprite, _target:*):RectangularButton{
			var box:RectangularButton = new RectangularButton();
			box.partner = _target;
			
			box.wide = 100;
			box.high = 15;
			//box.y = Math.random()*10;
			box.fillColor = 0xFFFFFF;
			box.alpha = .4;
			box.setText(_target.toString());
			_container.addChild(box);
			return box;
		}
		public function getData(_source:*):Array{
			return DisplayToolKit.getChildren(_source);
		}
	}
}