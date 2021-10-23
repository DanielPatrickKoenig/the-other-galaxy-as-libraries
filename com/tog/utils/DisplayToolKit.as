// ############################################################################
// DisplayToolKit - facilitates and assists with large DisplayObject opperations (ie. sorting, rostering, etc.)
// ============================================================================
// CREATED BY:	Dan Koenig
//
// CREATED ON: 10/18/2007
// ############################################################################
package com.tog.utils{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	public class DisplayToolKit{
		
		//getChildren() -- returns an array of all the direct tier 1 children of a display object
		public static function getChildren(d:DisplayObjectContainer):Array{
			var countInc:int = 0;
			var childList:Array = new Array();
			var stillCounting:Boolean = true;
			while(stillCounting){
				try{
					var currentChild:DisplayObject = d.getChildAt(countInc);
					childList.push(currentChild);
					countInc++;
				}
				catch(error:RangeError){
					//trace(error);
					stillCounting = false;
				}
			}
			return childList;
		}
		
		//getChildCount() -- returns an int equal to the number of direct tier 1 children a specified display object has
		public static function getChildCount(d:DisplayObjectContainer):int{
			return getChildren(d).length;
		}
		
		//getDescendants() -- returns an array of all descendants of a specified DisplayObject (ie. the objects children, their children, their childran and so on)
		public static function getDescendants(...args):Array{
			
			var d:* = args[0];
			if((d is DisplayObjectContainer)){
				var childList:Array;
				if(args[1]){
					childList = args[1];
				}
				else{
					childList = new Array();
				}
				var countInc:int = 0;
				var stillCounting:Boolean = true;
				while(stillCounting){
					try{
						var currentChild:DisplayObject = d.getChildAt(countInc);
						childList.push(currentChild);
						getDescendants(currentChild,childList);
						countInc++;
					}
					catch(error:RangeError){
						//trace(error);
						stillCounting = false;
					}
				}
			}
			return childList;
		}
		
		public static function createDescendantTree(...args):Array{
			
			var d:* = args[0];
			if(!(d is TextField)){
				var childList:Array;
				if(args[1]){
					childList = args[1];
				}
				else{
					childList = new Array();
				}
				var countInc:int = 0;
				var stillCounting:Boolean = true;
				while(stillCounting){
					try{
						var currentChild:DisplayObject = d.getChildAt(countInc);
						childList.push(climbDisplayHierarchy(currentChild));
						createDescendantTree(currentChild,childList);
						countInc++;
					}
					catch(error:RangeError){
						//trace(error);
						stillCounting = false;
					}
				}
			}
			return childList;
		}
		
		public static function climbDisplayHierarchy(_item:DisplayObject):Array{
			var items:Array = new Array();
			var currentItem:DisplayObject = _item;
			items.push(currentItem);
			while(currentItem.parent){
				currentItem = currentItem.parent;
				items.push(currentItem);
			}
			return items;
		}
		
		public static function getReletivieProperties(_item:DisplayObject, ...args):Object{
			var properties:Object = new Object();
			//var bounds:Object = _item.getBounds();
			
			properties.x = 0;
			properties.y = 0;
			//properties.xscale = 0;
			//properties.yscale = 0;
			if(args[0]){
				var _top:DisplayObject = args[0];
			}
			var hierarchy:Array = climbDisplayHierarchy(_item);
			for(var i:int = 0;i<hierarchy.length;i++){
				if(hierarchy[i].x){
					properties.x+=hierarchy[i].x;
					properties.y+=hierarchy[i].y;
				}
				if(hierarchy[i] == _top){
					i = hierarchy.length;
				}
			}
			return properties;
		}
		
		public static function removeChildren(d:DisplayObjectContainer):void{
			var children:Array = getChildren(d);
			for(var i:int = 0;i<children.length;i++){
				d.removeChild(children[i]);
			}
		}
		
		
		//getChildrenWith() -- returns an array of all children with a value of a specified property within a certian range
		public static function getChildrenWith(d:DisplayObjectContainer,property:String,opporator:String,value:*):Array{
			var sourceList:Array = getChildren(d);
			return filter(sourceList,property,opporator,value);
		}
		
		//getDescendantsWith() -- returns an array of all descendants with a value of a specified property within a certian range
		public static function getDescendantsWith(d:DisplayObjectContainer,property:String,opporator:String,value:*):Array{
			var sourceList:Array = getDescendants(d);
			return filter(sourceList,property,opporator,value);
		}
		
		//filter() -- returns an array filtered within a pecified range
		private static function filter(sourceList:Array,property:String,opporator:String,value:*):Array{
			var childList:Array = new Array();
			for(var i:int = 0;i<sourceList.length;i++){
				var included:Boolean = false;
				if(opporator == "=="){
					included = sourceList[i][property] == value; 
				}
				else if(opporator == ">"){
					included = sourceList[i][property] > value;
				}
				else if(opporator == ">="){
					included = sourceList[i][property] >= value;
				}
				else if(opporator == "<"){
					included = sourceList[i][property] < value;
				}
				else if(opporator == "<="){
					included = sourceList[i][property] <= value;
				}
				else if(opporator == "!="){
					included = sourceList[i][property] != value;
				}
				if(included){
					childList.push(sourceList[i]);
				}
			}
			return childList;
		}
		
	}
}