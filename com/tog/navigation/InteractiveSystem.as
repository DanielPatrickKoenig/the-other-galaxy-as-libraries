package com.tog.navigation{
	import flash.events.MouseEvent;
	public interface InteractiveSystem{
		function clickItem(e:MouseEvent):void;
		function rolloverItem(e:MouseEvent):void;
		function rolloutItem(e:MouseEvent):void;
	}
}