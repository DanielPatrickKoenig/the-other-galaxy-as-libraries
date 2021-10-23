package com.tog.events{
	import flash.events.EventDispatcher;
	import com.tog.events.Dispatchable;
	public class Dispatcher implements Dispatchable{
		private var caller:*;
		protected var dispatcher:EventDispatcher;
		public function Dispatcher(...args){
			if(args[0]){
				caller = args[0];
			}
			setEventDispatcher(createDispatcher());
		}
		protected function createDispatcher():EventDispatcher{
			var _dispatcher:EventDispatcher;
			if(caller && caller is EventDispatcher){
				_dispatcher = caller;
			}
			else{
				_dispatcher = new EventDispatcher();
			}
			return _dispatcher;
		}
		public function getEventDispatcher():EventDispatcher{
			return dispatcher;
		}
		public function setEventDispatcher(eventDispatcher:EventDispatcher):void{
			dispatcher = eventDispatcher;
		}
	}
}