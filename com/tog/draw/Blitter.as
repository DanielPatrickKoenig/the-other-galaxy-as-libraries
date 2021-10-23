package com.tog.draw{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import com.tog.draw.Asset;
	import com.tog.events.AssetEvent;
	import com.tog.events.BlitEvent;
	import flash.events.EventDispatcher;
	public class Blitter extends EventDispatcher{
		private var asset:Asset;
		private var bmd:BitmapData;
		public function Blitter(_path:String){
			
			asset = new Asset(_path);
			
			asset.addEventListener(AssetEvent.LOADED, assetLoaded);
			
		}
		private function assetLoaded(e:AssetEvent):void{
			
			bmd = new BitmapData(asset.width, asset.height);
			bmd.draw(asset);
			this.dispatchEvent(new BlitEvent(bmd,BlitEvent.READY));
			
		}
		public function createBitmap():Bitmap{
			
			return new Bitmap(bmd);
			
		}
	}
}