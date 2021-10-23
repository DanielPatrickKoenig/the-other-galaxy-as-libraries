package com.tog.events{
	import flash.events.EventDispatcher;
	public interface Dispatchable{
		function getEventDispatcher():EventDispatcher;
		function setEventDispatcher(eventDispatcher:EventDispatcher):void;
	}
}