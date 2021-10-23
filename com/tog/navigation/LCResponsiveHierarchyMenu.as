
package com.tog.navigation{
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.tog.navigation.RectangularButton;
	import com.tog.navigation.HierarchyMenu;
	import com.tog.utils.DisplayToolKit;
	import flash.display.Sprite;
	import com.tog.composition.Layout;
	
	import flash.xml.XMLDocument;
	import com.tog.comm.LCSend;
	import com.tog.comm.LCReceiver;
	import com.tog.events.LCReceivalEvent;
	
	public class LCResponsiveHierarchyMenu extends HierarchyMenu{
		protected var currentMenuItem:*;
		private var lcs:LCSend;
		private var lcRec:LCReceiver;
		protected var currentHighlightedItem:String;
		public function LCResponsiveHierarchyMenu(...args){
			super(args[0], args[1], args[2]);
			lcs = new LCSend("_seconday_connection");
			
			lcRec = new LCReceiver("_primary_connection");
			lcRec.addEventListener(LCReceivalEvent.RECEIVAL, received);
			
			
		}
		public override function clickItem(e:MouseEvent):void{
			currentMenuItem = e.target;
			change();
			send(modifier(e.target.getId().toString())+"/click");
			
			
		}
		
		public override function pressItem(e:MouseEvent):void{
			deSelectItem(e);
			currentHighlightedItem = e.target.getId().toString()
			send(modifier(e.target.getId().toString())+"/highlight");
		}
		
		public override function deSelectItem(e:MouseEvent):void{
			send(e.target.getId().toString()+"/hide");
		}
		
		protected function received(e:LCReceivalEvent):void{
			var receivedData:String = e.data.toString();
			onDataReceived(receivedData);
		}
		protected function onDataReceived(receivedData:String):void{
			
			var _rb:RectangularButton = RectangularButton(currentMenuItem);
			var currentMode:int = _rb.getMode();
			if(currentMode>0){
				_rb.setMode(0);
				DisplayToolKit.removeChildren(_rb.subMenu);
				Layout.updateAll();
			}
			else{
				_rb.setMode(1);
				var menuAddition:Sprite = createMenu(_rb.subMenu, new XMLDocument(receivedData));
				Layout.updateAll();
				//click(_rb.subMenu, new XMLDocument(e.data));
			}
		}
		protected function send(protocal:String):void{
			lcs.send(protocal);
		}
		protected function modifier(_txt:String):String{
			return _txt;
		}
		public override function destroy():void{
			lcRec.destroy();
			lcs.destroy();
			parent.removeChild(this);
			
		}
	}
}