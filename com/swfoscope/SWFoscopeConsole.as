package com.swfoscope{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.display.Sprite;
	
	import com.tog.comm.LCReceiver;
	import com.tog.events.LCReceivalEvent;
	
	import com.swfoscope.Inspector;
	public class SWFoscopeConsole extends Sprite{
		private var lcRec:LCReceiver;
		
		private var hm:Inspector;
		
		public function SWFoscopeConsole(){
			
			lcRec = new LCReceiver("_dpk_connection");
			lcRec.addEventListener(LCReceivalEvent.RECEIVAL, received);
			
			//var dctx:DisplayChildrenToXML = new DisplayChildrenToXML(con);
			//var xmlData:XMLDocument = dctx.xmlDoc;
			
			//var hm:HierarchyMenu = new HierarchyMenu(xmlData,0,0);
			//addChild(hm);
		}
		
		public function received(e:LCReceivalEvent):void{
			
			if(hm){
				hm.destroy();
				removeChild(hm);
				hm = null;
			}
			hm = new Inspector(new XMLDocument(e.data),0,0);
			addChild(hm);
		}
	}
	
}