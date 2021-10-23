/*
########################################################################
Layout facilitates the layout of display objects
Author: Dan Koenig

########################################################################
//*/
package com.tog.composition{
	import com.tog.utils.DisplayToolKit;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	public class Layout{
		public var doc:DisplayObjectContainer;
		public var children:Array;
		public var type:*;
		public var startX:Number;
		public var startY:Number;
		public static var instances:Array;
		public function Layout(_doc:DisplayObjectContainer, _type:*, ...args){
			startX = 0;
			startY = 0;
			if(args[0]){
				startX = args[0];
			}
			if(args[1]){
				startY = args[1];
			}
			doc = _doc;
			type = _type;
			doc.x = startX;
			doc.y = startY;
			redraw();
			if(!instances){
				instances = new Array();
			}
			instances.push(this);
			doc.addEventListener(Event.ADDED, itemsAdded);
			doc.addEventListener(Event.REMOVED, itemsAdded);
			//type.compose();
			//compose();
		}
		
		public static function updateAll():void{
			for(var i:int = 0;i<instances.length;i++){
				instances[i].redraw();
			}
		}
		
		public function redraw():void{
			children = DisplayToolKit.getChildren(doc);
			type.items = children;
		}
		
		private function itemsAdded(e:Event):void{
			children = DisplayToolKit.getChildren(doc);
			type.items = children;
		}
		
		
		public function set reverse(val:Boolean):void{
			type.reverse = val
		}
		public function get reverse():Boolean{
			return type.reverse;
		}
		public function set x(val:Number):void{
			doc.x = val;
		}
		public function get x():Number{
			return doc.x;
		}
		public function set y(val:Number):void{
			doc.y = val;
		}
		public function get y():Number{
			return doc.y;
		}
		public function set maxX(val:Number):void{
			type.maxX = val;
		}
		public function get maxX():Number{
			return type.maxX;
		}
		public function set maxY(val:Number):void{
			type.maxY = val;
		}
		public function get maxY():Number{
			return type.maxY;
		}
	}
}