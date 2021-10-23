package com.tog.comm{
	import flash.display.Sprite;
	import com.tog.comm.LCReceiver;
	import com.tog.events.LCReceivalEvent;
	import flash.text.TextField;
	public class ErrorProbe extends Sprite{
		private var lcRec:LCReceiver;
		private var tf:TextField;
		public function ErrorProbe(){
			tf = new TextField();
			tf.text = "No errors found.";
			this.addChild(tf);
			lcRec = new LCReceiver("error_connection", this);
			addEventListener(LCReceivalEvent.RECEIVAL, received);
		}
		private function received(e:LCReceivalEvent):void{
			tf.text = e.data.toString();
		}
	}
}