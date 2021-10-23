// ############################################################################
// DisplayHierarchyMenu - a menu built on a display hierarchy
// ============================================================================
// CREATED BY:	Dan Koenig
//
// CREATED ON: 11/27/2008
// ############################################################################
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
		private var filter:Class;
		private var stepValue:Number;
		private var buffer:Number;
		private var color:Number;
		private var buttonWide:Number;
		private var buttonHigh:Number;
		private var textSize:Number;
		private var textColor:Number;
		public function DisplayHierarchyMenu(...args){
			stepValue = 10;
			buffer = 0;
			color = 0xFFFFCC;
			buttonWide = 100;
			buttonHigh = 15;
			textSize = 7;
			textColor = 0x000000;
			
			var _list:Array = ["stepValue", "buffer", "color", "bottonWide", "buttonHigh", "textSize", "textColor"];
			var countStart:int;
			if(args[0] is String){
				loadInit(args[0], args[1], args[2], args[3]);
				countStart = 4;
			}
			else if(args[0] is DisplayObjectContainer){
				init(args[0], args[1]);
				countStart = 2;
			}
			for(var i:int = countStart; i<args.length;i++){
				this[_list[i-countStart]] = args[i];
			}
		}
		
		public function loadInit(_source:String, _filter:Class, _x:Number, _y:Number):void{
			
			var file:String = _source;
			filter = _filter;
			container = new Sprite();
			container.x = _x;
			container.y = _y;
			this.addChild(container);
			
			this.addEventListener(RecursionEvent.COMPLETE, targetLoaded);
			var pg:ProgressiveLoaderAS3 = new ProgressiveLoaderAS3([{asset:file, displayObject:container}], this);
			
		}
		
		public function init(_container:Sprite, _filter:Class):void{
			
			container = _container;
			filter = _filter;
			
		}
		
		private function targetLoaded(e:RecursionEvent):void{
			
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
				if(_rb.partner is filter){
					var menuAddition:Sprite = createMenu(_rb.subMenu, _rb.partner);
				}
				Layout.updateAll();
				click(_rb.subMenu, _rb.partner);
			}
		
		}
		
		public function click(_sub:DisplayObjectContainer, _partner:DisplayObjectContainer):void{
			
		}
		
		public function rolloverItem(e:MouseEvent):void{
			
		}
		
		public function rolloutItem(e:MouseEvent):void{
			
		}
		
		private function createMenu(_owner:DisplayObjectContainer,_target:*):Sprite{
			var menuContainer:Sprite = new Sprite();
			_owner.addChild(menuContainer);
			var menu:Sprite = new Sprite();
			var childList:Array = new Array();
			menuContainer.addChild(menu);
			menuContainer.x = stepValue;
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
				var childLayout:Layout = subLayout(childList[i]);
				
			}
			var menuLayout:Layout = mainLayout(menu);
			//var menuContainerLayout:Layout = new Layout(menuContainer,new Column());
			//Layout.updateAll();
			return menuContainer;
		}
		public function createMenuItem(_container:Sprite, _target:*):RectangularButton{
			var box:RectangularButton = new RectangularButton();
			box.partner = _target;
			
			box.wide = buttonWide;
			box.high = buttonHigh;
			//box.y = Math.random()*10;
			box.fillColor = color;
			box.alpha = .4;
			box.setText(_target.toString());
			_container.addChild(box);
			return box;
		}
		public function getData(_source:*):Array{
			return DisplayToolKit.getChildren(_source);
		}
		public function mainLayout(_container:DisplayObjectContainer):Layout{
			return new Layout(_container,new Stack());
		}
		public function subLayout(_container:DisplayObjectContainer):Layout{
			return new Layout(_container,new Stack());
		}
	}
}