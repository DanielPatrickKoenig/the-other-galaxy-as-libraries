// ############################################################################
// DisplayLogger - a tool for dicecting a display tree
// ============================================================================
// CREATED BY:	Dan Koenig
//
// CREATED ON: 11/27/2008
// ############################################################################
package com.tog.navigation{
	import com.tog.navigation.DisplayHierarchyMenu;
	import com.tog.navigation.RectangularButton;
	import com.tog.draw.Box;
	import flash.events.MouseEvent;
	public class DisplayLogger extends DisplayHierarchyMenu{
		private var marker:Box;
		public function DisplayLogger(...args){
			super(args[0], args[1], args[2], args[3]);
			marker = new Box();
			this.addChild(marker);
			//marker.alpha = .5;
			marker.fillAlpha = 0;
			marker.strokeAlpha = 1;
			marker.strokeWeight = 0;
			marker.strokeColor = 0xCC0000;
			marker.cornerRadius = 0;
		}
		public override function rolloverItem(e:MouseEvent):void{
			var _rb:* = RectangularButton(e.target).partner;
			var pos:Object = _rb.getBounds(this);
			marker.visible = true;
			marker.x = pos.x;
			marker.y = pos.y;
			marker.wide = pos.width;
			marker.high = pos.height;
			marker.cornerRadius = 0;
		}
		public override function rolloutItem(e:MouseEvent):void{
			var _rb:* = RectangularButton(e.target).partner;
			marker.visible = false;
		}
	}
}