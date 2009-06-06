package com.j_nid.utils {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class CairngormUtils	{
		
		public static function dispatchEvent(eventName:String,
		                                     data:Object=null):void {
			var event:CairngormEvent = new CairngormEvent(eventName);
			event.data = data;
			event.dispatch();
		}
	}
}