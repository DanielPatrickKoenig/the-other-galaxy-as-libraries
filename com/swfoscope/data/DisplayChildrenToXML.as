package com.swfoscope.data{
	import flash.xml.XMLDocument;
	import com.tog.utils.DisplayToolKit;
	import flash.display.DisplayObjectContainer;
	public class DisplayChildrenToXML{
		private var container:DisplayObjectContainer;
		private var _xml:XML;
		private var _xmlDoc:XMLDocument;
		private var children:Array;
		public function DisplayChildrenToXML(_container:DisplayObjectContainer){
			container = _container;
			
			//xml = createXML();
			//_xmlDoc = creatXMLDoc();
		}
		//private function createXML():XML{
			
		//}
		private function createXMLDoc():XMLDocument{
			var xmlString:String = "";
			//xmlString += "<"+container.name.toString()+">";
			for(var i:int = 0;i<children.length;i++){
				var childCount:int = 0;
				try{
					childCount = DisplayToolKit.getChildCount(children[i]);
				}
				catch(e:Error){
					
				}
				var dt:String = children[i].toString().split(" ")[1];
				var dataType:String = dt.split("]")[0];
				//xmlString+="<"+children[i].name.toString()+":|:c:|:"+childCount+":|:c:|:"+dataType+"/>";
				xmlString+="<"+children[i].name.toString()+":|:c:|:"+childCount+"/>";
			}
			//xmlString+="</"+container.name.toString()+">";
			return new XMLDocument(xmlString);
		}
		public function get xmlDoc():XMLDocument{
			children = DisplayToolKit.getChildren(container);
			_xmlDoc = createXMLDoc();
			return _xmlDoc;
		}
	}
}