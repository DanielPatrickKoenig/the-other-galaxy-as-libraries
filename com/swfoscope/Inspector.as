// ############################################################################
// Inspector - a tool for inspecting and modifying display objects via local connection
// ============================================================================
// CREATED BY:	Dan Koenig -- dpkoenig27@yahoo.com
//
// CREATED ON: 11/28/08
// ############################################################################
package com.swfoscope{
	
	import com.tog.navigation.LCResponsiveHierarchyMenu;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import com.tog.events.LCReceivalEvent;
	import com.tog.composition.Layout;
	import com.tog.composition.Stack;
	import com.tog.composition.SideStack;
	import com.tog.composition.Default;
	import com.tog.draw.ButtonView;
	import com.tog.utils.DisplayToolKit;
	import com.swfoscope.draw.SWFoscopeNavButtonArt;
	import com.tog.draw.Box;
	import com.tog.widgets.Scroller;
	import flash.display.SimpleButton;
	import flash.events.FocusEvent;
	public class Inspector extends LCResponsiveHierarchyMenu{
		private var inspector:Sprite;
		private var inspectorBox:Box;
		private var propertyItems:Array;
		private var format:TextFormat;
		private var scroller:Scroller;
		private var inspectorScroller:Scroller;
		private var maskWidth:Number;
		private var utilitiesMenuBox:Box;
		private var modeToggleTxt:TextField;
		public function Inspector(...args){
			super(args[0], args[1], args[2]);
			var maskBox:Box = new Box();
			maskWidth = 330;
			var menuSprite:Sprite = getMenu();
			menuSprite.y = 50;
			maskBox.y = menuSprite.y;
			maskBox.high = 320;
			maskBox.wide = maskWidth;
			menuSprite.mask = maskBox;
			scroller = new Scroller(menuSprite, maskBox.high, maskBox.high);
			scroller.x = maskBox.wide;
			scroller.y = menuSprite.y;
			addChild(scroller);
		}
		
		protected override function received(e:LCReceivalEvent):void{
			var receivedData:String = e.data.toString();
			if(receivedData.split("///")[0] == "DISPLAY_OBJECT_DESCRIPTION"){
				createInspector(receivedData.split("///")[1],receivedData.split("///")[2]);
				//createInspectorScroller(380);
				//createUtilitiesMenu(380);
				
			}
			else if(receivedData.split("///")[0] == "DISPLAY_OBJECT_UPDATE"){
				updateInspector(receivedData.split("///")[1],receivedData.split("///")[2]);
				
			}
			else{
				
				onDataReceived(receivedData);
			}
		}
		private function selectField(e:FocusEvent):void{
			for(var i:int = 0;i<propertyItems.length;i++){
				if(e.target == propertyItems[i].vf){
					e.target.borderColor = 0xCC0000;
					propertyItems[i].selected = true;
				}
			}
		}
		private function deselectField(e:FocusEvent):void{
			for(var i:int = 0;i<propertyItems.length;i++){
				if(e.target == propertyItems[i].vf){
					e.target.borderColor = 0x000000;
					propertyItems[i].selected = false;
				}
			}
		}
		public function createInspectorItem(property:String, value:String):Sprite{
			
			var fieldHeight:Number = 20;
			var item:Sprite = new Sprite();
			var propertyField:TextField = new TextField();
			//propertyField.text = property;
			propertyField.height = fieldHeight;
			propertyField.width = 60;
			if(property == ""){
				propertyField.type = "input";
				propertyField.border = true;
				propertyField.text = "enter a property";
			}
			else{
				propertyField.text = property;
				propertyField.selectable = false;
			}
			item.addChild(propertyField);
			var valueField:TextField = new TextField();
			if(property == ""){
				valueField.text = "enter a value";
			}
			else{
				valueField.text = value;
			}
			valueField.height = fieldHeight;
			valueField.width = 55;
			valueField.type = "input";
			valueField.border = true;
			item.addChild(valueField);
			propertyField.embedFonts = true;
			valueField.embedFonts = true;
			propertyField.setTextFormat(format);
			valueField.setTextFormat(format);
			valueField.defaultTextFormat = format;
			valueField.addEventListener(FocusEvent.FOCUS_IN, selectField);
			valueField.addEventListener(FocusEvent.FOCUS_OUT, deselectField);
			var modBox:Box = new Box();
			modBox.high = 20;
			modBox.fillColor = 0x666666;
			var modBoxTF:TextField = new TextField();
			var modBoxFormat:TextFormat = new TextFormat();
			modBoxFormat.font = format.font;
			modBoxFormat.size = format.size;
			modBoxFormat.color = 0xFFFFFF;
			modBoxTF.text = "modify";
			modBoxTF.autoSize = "left";
			modBoxTF.embedFonts = true;
			modBoxTF.setTextFormat(modBoxFormat);
			modBox.wide = modBoxTF.width;
			modBox.addChild(modBoxTF);
			
			var modBoxOver:Box = new Box();
			modBoxOver.high = 20;
			var modBoxOverTF:TextField = new TextField();
			modBoxOverTF.text = "modify";
			modBoxOverTF.autoSize = "left";
			modBoxOverTF.embedFonts = true;
			modBoxOverTF.setTextFormat(modBoxFormat);
			modBoxOver.wide = modBoxOverTF.width;
			modBoxOver.addChild(modBoxOverTF);
			
			var modButton:SimpleButton = new SimpleButton();
			modButton.upState = modBox;
			modButton.downState = modBox;
			modButton.overState = modBoxOver;
			modButton.hitTestState = modBox;
			item.addChild(modButton);
			modButton.addEventListener(MouseEvent.MOUSE_DOWN, modify);
			propertyItems.push({pf:propertyField, vf:valueField, button:modButton, selected:false});
			
			return item;
		}
		public function createUtilityButton(_text:String):SimpleButton{
			var applyButton:SimpleButton = new SimpleButton();
			var box:Box = new Box();
			box.wide = 100;
			box.high = 20;
			box.fillColor = 0x666666;
			var buttonTxt:TextField = new TextField();
			if(_text == "real time mode on"){
				modeToggleTxt = buttonTxt;
			}
			buttonTxt.autoSize = "left";
			buttonTxt.text = _text;
			buttonTxt.setTextFormat(format);
			buttonTxt.defaultTextFormat = format;
			box.addChild(buttonTxt);
			//box.x = 60;
			//applyButton.addChild(box);
			applyButton.upState = box;
			applyButton.overState = box;
			applyButton.downState = box;
			applyButton.hitTestState = box;
			return applyButton;
		}
		public function updateInspector(inspectorData:String, dataType:String):void{
			var inspectorDataList:Array = inspectorData.split("|||");
			for(var i:int = 1;i<inspectorDataList.length;i++){
				if(!propertyItems[i-1].selected){
					try{
						var valuePair:String = inspectorDataList[i];
						propertyItems[i-1].vf.text = valuePair.split(":::")[1].toString();
						//propertyItems[i-1].vf.text = "hello";
					}
					catch(e:Error){
					}
				}
			}
		}
		public function createInspector(inspectorData:String, dataType:String):void{
			format = new TextFormat();
			format.size = 10;
			format.font = "Arial";
			if(inspector){
				inspector.y = 0;
				inspectorBox.y = 0;
				removeChild(inspector);
				removeChild(inspectorScroller);
				removeChild(inspectorBox);
				removeChild(utilitiesMenuBox);
			}
			
			var border:Number = 5;
			
			if(!inspectorBox){
				inspectorBox = new Box();
				inspector = new Sprite();
			}
			
			
			DisplayToolKit.removeChildren(inspector);
			
			
			var dtField:TextField = new TextField();
			dtField.embedFonts = true;
			dtField.text = dataType;
			dtField.autoSize = "left";
			inspector.addChild(dtField);
			dtField.setTextFormat(format);
			
			propertyItems = new Array();
			var inspectorDataList:Array = inspectorData.split("|||");
			var itemContainer:Sprite = new Sprite();
			
			inspector.addChild(itemContainer);
			for(var i:int = 1;i<inspectorDataList.length;i++){
				try{
					var valuePair:String = inspectorDataList[i];
					var item:Sprite = createInspectorItem(valuePair.split(":::")[0], valuePair.split(":::")[1].toString());
					itemContainer.addChild(item);
					
					var itemLayout:Layout = new Layout(item, new Default());
				}
				catch(e:Error){
				}
			}
			//var maskBox:Box = new Box();
			//maskBox.wide = 165;
			//maskBox.high = 120;
			
			//*
			var itemContainerLayout:Layout = new Layout(itemContainer, new Stack(5));
			var customItem:Sprite = createInspectorItem("", "");
			inspector.addChild(customItem);
				
			var customItemLayout:Layout = new Layout(customItem, new Default());
			//*/
			
			addChild(inspectorBox);
			addChild(inspector);
			var inspectorLayout:Layout = new Layout(inspector, new Stack(5));
			//maskBox.x = itemContainer.x;
			//maskBox.y = itemContainer.y;
			//inspector.addChild(maskBox);
			//itemContainer.mask = maskBox;
			inspector.x = getMenu().x+maskWidth+20;
			inspectorBox.x = inspector.x-border;
			inspectorBox.y = inspector.y-border;
			inspectorBox.wide = inspector.width+(border*2);
			inspectorBox.high = inspector.height+(border*2);
			inspectorBox.fillColor = 0xCCCCCC;
			inspectorBox.strokeAlpha = .6;
		 
			var _highVal:Number = 370;
			utilitiesMenuBox = new Box();
			addChild(utilitiesMenuBox);
			
			
			var stub:Sprite = new Sprite();
			utilitiesMenuBox.addChild(stub);
			addUtilityButton(_highVal, border, "real time mode on", toggleInspectionMode);
			//addUtilityButton(_highVal, border, "reset", reset);
			
			var utilityMenu:Layout = new Layout(utilitiesMenuBox, new SideStack(border));
			
			utilitiesMenuBox.y = _highVal;
			utilitiesMenuBox.fillColor = 0xCCCCCC;
			utilitiesMenuBox.strokeAlpha = 1;
			
			
			
			//if(!inspectorScroller){
				inspectorScroller = new Scroller(inspector, _highVal, _highVal);
			//}
			
			addChild(inspectorScroller);
			inspectorScroller.x = inspector.x+inspector.width+border;
			
			
			utilitiesMenuBox.wide = 550;
			
		}
		
		private function addUtilityButton(_highVal:Number, _border:Number, _text:String, _function:Function):void{
			//if(!utilitiesMenuBox){
				
				var utilityButton:SimpleButton = createUtilityButton(_text);
				utilityButton.y = _border;
				//utilityButton.x = _border;
				
				
				
				utilitiesMenuBox.high = utilityButton.height+_border*2;
				utilityButton.addEventListener(MouseEvent.MOUSE_DOWN, _function);
			//}
			utilitiesMenuBox.addChild(utilityButton);
		}
		
		protected override function change():void{
			var childMenuItems:Array = DisplayToolKit.getDescendants(this);
			for(var i:int = 0;i<childMenuItems.length;i++){
				try{
					childMenuItems[i].getView().deactivateHighlight();
				}
				catch(e:Error){
				}
			}
			currentMenuItem.getView().activateHighlight();
			scroller.update();
		}
		
		protected function modify(e:MouseEvent):void{
			send(currentHighlightedItem.split(":|:c:|:")[0]+"/modify/"+createModificationProtocal(e.target));
		}
		protected function toggleInspectionMode(e:MouseEvent):void{
			if(modeToggleTxt.text == "real time mode on"){
				modeToggleTxt.text = "real time mode off";
			}
			else{
				modeToggleTxt.text = "real time mode on";
			}
			send(currentHighlightedItem.split(":|:c:|:")[0]+"/toggleInspectionMode/");
		}
		protected function reset(e:MouseEvent):void{
			
			send(currentHighlightedItem.split(":|:c:|:")[0]+"/reset/");
			destroy();
		}
		protected function createModificationProtocal(_d:Object):String{
			var modificationProtocal:String = "";
			for(var i:int = 0;i<propertyItems.length;i++){
				if(_d == propertyItems[i].button){
					modificationProtocal+="|||"+propertyItems[i].pf.text+":::"+propertyItems[i].vf.text;
				}
			}
			return modificationProtocal;
		}
		protected override function createButtonArt(_txt:String):ButtonView{
			var buttonArt:SWFoscopeNavButtonArt = new SWFoscopeNavButtonArt(_txt.split(":|:c:|:")[2],{children:_txt.split(":|:c:|:")[1], text:_txt.split(":|:c:|:")[2]});
			return buttonArt;
		}
		protected override function modifier(_txt:String):String{
			return _txt.split(":|:c:|:")[0];
		}
		
		protected override function rolloverItem(e:MouseEvent):void{
			e.target.getView().changeTextFormat("color", 0xCC0000);
		}
		protected override function rolloutItem(e:MouseEvent):void{
			e.target.getView().changeTextFormat("color", 0xFFFFFF);
		}
		
	}
}