package com.j_nid.models {
	
	import com.j_nid.utils.Utils;
	
	import flash.events.EventDispatcher;
	
	public class Model extends EventDispatcher {
		
		public var id:int;
		public var sortIndex:int;
		protected var utils:Utils = Utils.getInstance();
		
		public function Model()	{
			super();
	    }
	}
}