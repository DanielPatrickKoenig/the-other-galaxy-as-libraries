// ############################################################################
// Tool - A basic behavior engine
// ============================================================================
// CREATED BY:	Dan Koenig -- dan@theothergalaxy.com
//
// ############################################################################
package com.tog.behavior{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.tog.utils.HyperMath;
	public class Tool{
		private var manifest:Array;
		private var modifiedProperties:Array;
		private var shape:*;
		private var container:Sprite;
		private var type:*;
		private var defaults:Array;
		private var anchor:Object; 
		private var spawnMode:Boolean;
		private var modMode:Boolean;
		private var cumulationList:Array;
		public function Tool(_container:Sprite, _type:*, _manifest:Array, _modifiedProperties:Array, _defaults:Array){
			container = _container;
			type = _type;
			manifest = _manifest;
			modifiedProperties = _modifiedProperties;
			defaults = _defaults;
			spawnMode = false;
			modMode = false;
			cumulationList = new Array();
			container.addEventListener(MouseEvent.MOUSE_DOWN,spawn);
			container.addEventListener(MouseEvent.MOUSE_MOVE,modify);
			container.addEventListener(MouseEvent.MOUSE_UP,confirm);
		}
		private function spawn(event:MouseEvent):void{
			spawnMode = true;
			shape = new type();
			manifest.push();
			anchor = {x:container.mouseX, y:container.mouseY};
			for(var i:Number= 0;i<defaults.length;i++){
				var value:*;
				if(defaults[i].inherit){
					value = container[defaults[i].inherit];
				}
				else if(defaults[i].modifier){
					value = container[defaults[i].modifier];
				}
				else{
					value = defaults[i].value;
				}
				shape[defaults[i].property] = value;
			}
		}
		private function modify(event:MouseEvent):void{
			if(spawnMode){
				if(!modMode){
					container.addChild(shape);
				}
				var dist:Number = HyperMath.getDistance(anchor.x,anchor.y,container.mouseX,container.mouseY);
				for(var i:Number= 0;i<modifiedProperties.length;i++){
					var factor:Number = 1;
					//*
					if(!modMode){
						cumulationList[i] = 0;
						if(modifiedProperties[i].cumulative){
							//cumulationList[i] = shape[modifiedProperties[i].modifier];
						}
					}
					//*/
					var value:*;
					if(modifiedProperties[i].factor){
						factor = modifiedProperties[i].factor;
					}
					if(modifiedProperties[i].inherit){
						value = (shape[modifiedProperties[i].inherit]*factor)+cumulationList[i];
					}
					else if(modifiedProperties[i].modifier){
						value = (shape[modifiedProperties[i].modifier]*factor)+cumulationList[i];
					}
					else{
						value = (dist*factor)+cumulationList[i];
					}
					shape[modifiedProperties[i].property] = value;
				}
				modMode = true;
			}
		}
		private function confirm(event:MouseEvent):void{
			spawnMode = false;
			modMode = false;
		}
	}
}