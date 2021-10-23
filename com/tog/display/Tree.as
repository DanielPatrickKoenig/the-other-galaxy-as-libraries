package com.tog.display{
	public class Tree{
		private var list:Array;
		public function Tree(_list:Array){
			list = _list;
		}
		public function getMaxLength():int{
			var maxLength:int = 0;
			for(var i:int = 0;i<list.length;i++){
				if(list[i].length > maxLength){
					maxLength = list[i].length;
				}
			}
			return maxLength;
		}
		
		public function getCases(level:int, _list:Array):Array{
			var maxLength:int = getMaxLength();
			if(level < maxLength){
				var caseObject:Object = new Object();
				var cases:Array = _list;
				for(var i:int = 0;i<list.length;i++){
					var inside:Boolean = false;
					var currentMatch:* = list[i][level];
					trace(list[i][level]);
					for(var j:int = 0;j<cases.length;j++){
						if(currentMatch == cases[j].node){
							inside = true;
						}
					}
					if(!inside){
						caseObject.node = currentMatch;
						caseObject.children = new Array();
						var caseString = caseObject.node.toString()+"\r";
						//caseString+=caseObject.children.toString().split(",").join("\r");
						cases.push(caseObject);
						getCases(level+1, caseObject.children);
					}
				}
			}
			return cases;
		}
		/*
		public function outputTree():String{
			var cases:Array = getCases(1, new Array());
			
			
		}
		//*/
		
	}
}