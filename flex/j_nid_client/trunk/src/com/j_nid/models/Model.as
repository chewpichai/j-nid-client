package com.j_nid.models {
	
	import flash.events.EventDispatcher;
	
	public class Model extends EventDispatcher {
		
		private var _id:int;
		private var _sortIndex:int;
		
		public function Model()	{
			super();
	    }
		
		public function set id(obj:int):void {
			_id = obj;
		}
		
		public function get id():int {
			return _id;
		}
		
		public function get sortIndex():int {
			return _sortIndex;
		}

		public function set sortIndex(obj:int):void {
			_sortIndex = obj;
		}
	}
}