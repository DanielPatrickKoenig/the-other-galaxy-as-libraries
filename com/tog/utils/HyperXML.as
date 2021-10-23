/*
########################################################################
HyperXML an xml parsing tool
Author: Dan Koenig

########################################################################
//*/
package com.tog.utils{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	public class HyperXML{
		public static var collector:Array;
		//*
		private static function validateNode(_node:*):Boolean{
			var valid:Boolean = true;
			if(_node == undefined || _node == null || _node.toString().toLowerCase() == "undefined" || _node.toString().toLowerCase() == "null"){
				valid = false;
			}
			return valid;
		}
		public static function getNodesByAttribute(_node:XML, _value:String, _property:String):XMLList{
			var collector:XMLList;
			try{
				collector = _node..*.(hasOwnProperty("@"+_property) && @[_property] == _value);
				if(!validateNode(collector)){
					throw(new Error("E4X is not supported in this environment"));
				}
			}
			catch(e:Error){
				collector = new XMLList();
				var list:Array = _getNodesByAttribute(new XMLDocument(_node),_value,_property);
				for(var i:int = 0;i<list.length; i++){
					collector[i] = XML(list[i]);
				}
			}
			return collector;
		}
		
		public static function _getNodesByAttribute(node:XMLNode,theID:String,mark:String,...args):Array{
			if(!args[0]){
				collector = new Array();
				args[0] = collector;
			}
			
			var child:XMLNode;
			for(child = node.firstChild; child != null; child = child.nextSibling){
				_getNodesByAttribute(child,theID,mark,collector);
				if(child.attributes[mark] == theID){
					collector.push(child);
				}
			}
			return collector;
		}
		
		
		//*/
		
		public static function getNodesByName(_node:XML, _value:String):XMLList{
			var collector:XMLList;
			try{
				collector = _node..*.(name() == _value);
				if(!validateNode(collector)){
					throw(new Error("E4X is not supported in this environment"));
				}
			}
			catch(e:Error){
				collector = new XMLList();
				var list:Array = _getNodesByName(new XMLDocument(_node),_value);
				for(var i:int = 0;i<list.length; i++){
					collector[i] = XML(list[i]);
				}
			}
			return collector;
		}
		public static function _getNodesByName(node:XMLNode, theID:String, ...args):Array{
			if(!args[0]){
				collector = new Array();
				args[0] = collector;
			}
			var child:XMLNode;
			for(child = node.firstChild; child != null; child = child.nextSibling){
				_getNodesByName(child,theID,collector);
				if(child.nodeName == theID){
					collector.push(child);
				}
			}
			return collector;
		}
	}
}