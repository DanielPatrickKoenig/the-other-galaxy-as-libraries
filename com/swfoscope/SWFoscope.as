package com.swfoscope{
	import flash.xml.XMLDocument;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import com.swfoscope.data.DisplayChildrenToXML;
	import com.tog.utils.DisplayToolKit;
	import com.tog.comm.LCSend;
	import com.tog.comm.LCReceiver;
	import com.tog.events.LCReceivalEvent;
	import com.tog.draw.Box;
	
	import com.adobe.serialization.json.JSON;
	
	public class SWFoscope extends Sprite{
		private var lcs:LCSend;
		private var lcRec:LCReceiver;
		private var scope:DisplayObjectContainer;
		private var marker:Box;
		private var properties:Array;
		private var selectedObject:DisplayObject;
		private var timer:Timer;
		public static var logScope:DisplayObjectContainer;
		public static var sender:LCSend;
		private var startUpLC:LCSend;
		private var realTimeInspection:Boolean;
		public function SWFoscope(...args){
			scope = args[0];
			init();
		}
		private function reset(...args):void{
			/*
			scope.removeChild(marker);
			startUpLC.destroy();
			lcRec.destroy();
			lcs.destroy();
			startUpLC = null;
			marker = null;
			lcRec = null;
			lcs = null;
			init();
			//*/
			var dctx:DisplayChildrenToXML = new DisplayChildrenToXML(scope);
			var xmlData:XMLDocument = dctx.xmlDoc;
			startUpLC.send(xmlData.toString());
		}
		private function init():void{
			timer = new Timer(50);
			realTimeInspection = false;
			properties = ["x", "y", "alpha", "visible", "rotation", "xscale", "yscale", "width", "height", "text"];
			
			var additionalProperties:Array = ["accessibilityProperties", "blendMode", "cacheAsBitmap", "	filters", "loaderInfo", "mask", "mouseX", "mouseY", "name", "opaqueBackground", "prototype", "root", "	scale9Grid", "scaleX", "scaleY", "scrollRect", "stage", "transform", "	visible", "alwaysShowSelection", "antiAliasType", "	autoSize", "background", "backgroundColor", "border", "borderColor", "bottomScrollV", "caretIndex", "condenseWhite", "defaultTextFormat", "displayAsPassword", "embedFonts", "gridFitType", "htmlText", "length", "maxChars", "maxScrollH", "maxScrollV", "mouseEnabled", "mouseWheelEnabled", "multiline", "numLines", "restrict", "scrollH", "scrollV", "selectable", "selectionBeginIndex", "selectionEndIndex", "	sharpness", "styleSheet", "tabEnabled", "tabIndex", "textColor", "textHeight", "textWidth", "thickness", "type", "useRichTextClipboard", "wordWrap"];
			
			
			marker = new Box();
			scope.addChild(marker);
			//marker.alpha = .5;
			
			marker.fillColor = 0xFFFFFF;
			marker.fillAlpha = .2;
			marker.strokeAlpha = 1;
			marker.strokeWeight = 0;
			marker.strokeColor = 0xCC0000;
			marker.cornerRadius = 0;
			marker.visible = false;
			
			
			var dctx:DisplayChildrenToXML = new DisplayChildrenToXML(scope);
			var xmlData:XMLDocument = dctx.xmlDoc;
			
			startUpLC = new LCSend("_dpk_connection");
			startUpLC.send(xmlData.toString());
			
			lcs = new LCSend("_primary_connection");
			
			//lcs.send(dctx.xmlDoc.toString());
			
			lcRec = new LCReceiver("_seconday_connection");
			lcRec.addEventListener(LCReceivalEvent.RECEIVAL, received);
			
		}
		private function received(e:LCReceivalEvent):void{
			
			var targetDisplayObject:DisplayObject = getTargetDisplayObject(e.data.toString().split("/")[0]);
			
			var protocalString:String = null;
			if(e.data.toString().split("/").length>2){
				protocalString = e.data.toString().split("/")[2];
			}
			
			this[e.data.toString().split("/")[1]](targetDisplayObject, protocalString);
			
		}
		
		private function getTargetDisplayObject(_data:String):DisplayObject{
			var descendants:Array = DisplayToolKit.getDescendants(scope);
			var targetObject:DisplayObject;
			for(var i:int = 0;i<descendants.length;i++){
				if(descendants[i].name == _data){
					targetObject = descendants[i];
				}
			}
			return targetObject;
		}
		private function click(...args):void{
			var doc:DisplayObject = args[0];
			try{
			//if(doc is DisplayObjectContainer){
				
				var dctx:DisplayChildrenToXML = new DisplayChildrenToXML(DisplayObjectContainer(doc));
				var xmlData:XMLDocument = dctx.xmlDoc;
				lcs.send(String(xmlData));
			//}
			}
			catch(e:Error){
			}
		}
		private function startTimer():void{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, highlightListener);
			timer.addEventListener(TimerEvent.TIMER, highlightListener);
			timer.start();
		}
		private function highlight(...args):void{
			var doc:DisplayObject = args[0];
			selectedObject = doc;
			//var pos:Object = doc.getBounds(this);
			if(realTimeInspection){
				startTimer();
			}
			highlightObject();
			//marker.removeEventListener(Event.ENTER_FRAME, highlightListener);
			//marker.addEventListener(Event.ENTER_FRAME, highlightListener);
			lcs.send("DISPLAY_OBJECT_DESCRIPTION///"+getDisplayObjectData(doc)+"///"+doc.toString().slice(1,doc.toString().length-1));
			
		}
		private function toggleInspectionMode(...args):void{
			if(realTimeInspection){
				realTimeInspection = false;
				timer.stop();
			}
			else{
				realTimeInspection = true;
				startTimer();
			}
		}
		private function highlightListener(e:TimerEvent):void{
			highlightObject();
			lcs.send("DISPLAY_OBJECT_UPDATE///"+getDisplayObjectData(selectedObject)+"///"+selectedObject.toString().slice(1,selectedObject.toString().length-1));
		}
		private function highlightObject():void{
			var pos:Object = selectedObject.getBounds(this);
			marker.visible = true;
			marker.x = pos.x;
			marker.y = pos.y;
			marker.wide = pos.width;
			marker.high = pos.height;
			marker.cornerRadius = 0;
			
		}
		private function hide(...args):void{
			var doc:DisplayObject = args[0];
			marker.visible = false;
		}
		private function getDisplayObjectData(doc:DisplayObject):String{
			var propertyString:String = "";
			for(var i:int = 0;i<properties.length;i++){
				
				try{
					if(doc[properties[i]] is String || doc[properties[i]] is Number){
						propertyString+="|||"+properties[i]+":::"+doc[properties[i]].toString();
					}
					else{
						propertyString+="|||"+properties[i]+":::"+JSON.encode(doc[properties[i]]);
					}
				}
				catch(e:Error){
				}
				
			}
			return propertyString;
		}
		private function modify(...args):void{
			var doc:DisplayObject = args[0];
			var protocalList:Array = args[1].split("|||");
			for(var i:int = 1;i<protocalList.length;i++){
				var property:String = protocalList[i].split(":::")[0];
				var value:String = protocalList[i].split(":::")[1];
				try{
					if(doc[property] is Number){
						doc[property] = Number(value);
					}
					if(doc[property] is int){
						doc[property] = int(value);
					}
					if(doc[property] is uint){
						doc[property] = uint(value);
					}
					else if(doc[property] is String){
						doc[property] = String(value);
					}
					else if(doc[property] is Boolean){
						var bValue:Boolean;
						if(String(value) == "false"){
							bValue = false;
						}
						else if(String(value) == "true"){
							bValue = true;
						}
						doc[property] = bValue;
					}
					else{
						//var joiner:String = "\ ";
						//doc[property] = JSON.decode(value.split('"').join(joiner.split("")[0]+'"'));
						doc[property] = JSON.decode(value);
						//doc[property] = JSON.decode('{\"tabStops\":[],\"letterSpacing\":0,\"url\":\"\",\"bold\":false,\"italic\":false,\"font\":\"Arial\",\"size\":12,\"underline\":false,\"display\":\"block\",\"target\":\"\",\"align\":\"left\",\"color\":0,\"leftMargin\":0,\"rightMargin\":0,\"leading\":0,\"indent\":0,\"bullet\":false,\"blockIndent\":0,\"kerning\":false}');
						//var tfm:TextFormat = new TextFormat();
						//tfm.letterSpacing = 10;
						//doc[property] = tfm;
					}
				}
				catch(e:Error){
				}
				
			}
			//doc.visible = false;
		}
		private function set(_data:*):Class{
			var dataTypes:Array = [String, Number, Boolean, int];
			var dataType:Class;
			for(var i:int = 0;i<dataTypes.length;i++){
				if(_data is dataTypes[i]){
					dataType = dataTypes[i];
				}
			}
			return dataType;
		}
	}
}