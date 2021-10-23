package com.tog.widgets{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import com.tog.draw.Box;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	public class Scroller extends Sprite{
		private var target:DisplayObject;
		private var high:Number;
		private var scrolling:Boolean;
		private var scrollHandle:SimpleButton;
		private var scrollOffset:Number;
		private var scrollOverlay:DisplayObject;
		private var scrollBar:DisplayObject;
		private var margin:Number;
		private var maxScroll:Number;
		private var base:Number;
		private var liveArea:Number;
		public function Scroller(_target:DisplayObject, _high:Number, ...args){
			target = _target;
			high = _high;
			margin = 60;
			
			if(args[0]){
				liveArea = args[0];
				
			}
			else{
				liveArea = 0;
				
			}
			if(args[1]){
				base = args[1];
			}
			else{
				base = target.y;
			}
			
			
			scrollBar = createScrollBar();
			addChild(scrollBar);
			
			scrollHandle = createScrollHandle();
			addChild(scrollHandle);
			maxScroll = scrollBar.y+scrollBar.height-scrollHandle.height;
			scrollHandle.addEventListener(MouseEvent.MOUSE_DOWN, startScroll);
			
			update();
			
			visible = false;
		}
		protected function createScrollBar():DisplayObject{
			var _box:Box = new Box();
			_box.wide = 20;
			_box.high = high;
			_box.fillColor = 0xCCCCCC;
			return _box;
		}
		
		protected function createScrollHandle():SimpleButton{
			var _box:Box = new Box();
			_box.wide = 20;
			_box.high = _box.wide;
			_box.fillColor = 0x333333;
			var button:SimpleButton = new SimpleButton();
			button.upState = _box;
			button.downState = _box;
			button.overState = _box;
			button.hitTestState = _box;
			return button;
		}
		
		protected function createScrollOverlay():DisplayObject{
			var _box:Box = new Box();
			_box.wide = scrollBar.width+(margin*2);
			_box.high = scrollBar.height+(margin*2);
			_box.x = margin*-1;
			_box.y = margin*-1;
			_box.fillAlpha = 0;
			//_box.fillColor = 0xCCCCCC;
			return _box;
		}
		
		private function startScroll(e:MouseEvent):void{
			scrolling = true;
			scrollOffset = mouseY - e.target.y;
			if(!scrollOverlay){
				scrollOverlay = createScrollOverlay();
			}
			addChild(scrollOverlay);
			scrollOverlay.addEventListener(MouseEvent.MOUSE_MOVE, doScroll);
			scrollOverlay.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
			scrollOverlay.addEventListener(MouseEvent.MOUSE_OUT, stopScroll);
		}
		private function doScroll(e:MouseEvent):void{
			if(scrolling){
				
				scrollHandle.y = mouseY-scrollOffset;
				if(scrollHandle.y>maxScroll){
					scrollHandle.y = maxScroll;
				}
				if(scrollHandle.y<scrollBar.y){
					scrollHandle.y = scrollBar.y;
				}
				reaction();
			}
		}
		private function stopScroll(e:MouseEvent):void{
			scrolling = false;
			scrollOverlay.removeEventListener(MouseEvent.MOUSE_MOVE, doScroll);
			scrollOverlay.removeEventListener(MouseEvent.MOUSE_UP, stopScroll);
			removeChild(scrollOverlay);
		}
		protected function reaction():void{
			target.y = ((target.height-liveArea)*(getScrollValue()*-1))+base;
		}
		private function getScrollValue():Number{
			return (scrollHandle.y-scrollBar.y)/maxScroll;
		}
		public function update():void{
			var _timer:Timer = new Timer(500, 2);
            _timer.addEventListener(TimerEvent.TIMER, _update);
			_timer.start();
		}
		private function _update(e:TimerEvent):void{
			visible = false;
			if(target.height>liveArea){
				visible = true;
				reversePosition();
			}
			
		}
		private function reversePosition():void{
			var releventHeight:Number = target.height-liveArea;
			var currentPosition:Number = base-target.y;
			var currentRatio:Number = currentPosition/releventHeight;
			scrollHandle.y = scrollBar.y+((scrollBar.height-scrollHandle.height)*currentRatio);
		}
	}
}