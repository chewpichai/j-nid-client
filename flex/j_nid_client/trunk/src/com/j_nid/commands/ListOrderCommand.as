package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Order;
	import com.j_nid.utils.CairngormUtils;
	
	public class ListOrderCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:OrderDelegate = new OrderDelegate(this);
			delegate.listOrder();
		}
		
		override public function result(event:Object):void {
			super.result(event);
			Order.add(event.result.children());
			Order.loaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}