package com.j_nid.models {
	
	import com.j_nid.utils.CairngormUtils;
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class Model extends EventDispatcher {
		
		public var id:uint;
		
		protected var createEvent:String;
		protected var updateEvent:String;
		protected var deleteEvent:String;
		
		public function Model()	{
			super();
			this.id = 0;
	    }
	    
	    public function save():void {
	    	if (id > 0) {
	    		CairngormUtils.dispatchEvent(updateEvent, this);
	    	} else {
	    		CairngormUtils.dispatchEvent(createEvent, this);
	    	}
	    }
	    
	    public function remove():void {
	    	CairngormUtils.dispatchEvent(deleteEvent, this);
	    }
	}
}