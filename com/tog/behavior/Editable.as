package com.tog.behavior{
	import flash.events.MouseEvent;
	public interface Editable{
		function onMouseDown(e:MouseEvent):void;
		function onMouseMove(e:MouseEvent):void;
		function onMouseUp(e:MouseEvent):void;
	}
}