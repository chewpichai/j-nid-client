package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderDelegate;
	import com.j_nid.models.Order;

	public class UpdateOrderCommand extends RespondCommand {
		
		private var _order:Order;
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_order = event.data;
			var delegate:OrderDelegate = new OrderDelegate(this);
			delegate.updateOrder(_order);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			_order.dispatchUpdated();
		}
	}
}