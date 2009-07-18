package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderItemDelegate;
	import com.j_nid.models.OrderItem;

	public class DeleteOrderItemCommand extends RespondCommand {
		
		private var _orderItem:OrderItem;
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_orderItem = event.data;
			var delegate:OrderItemDelegate = new OrderItemDelegate(this);
			delegate.deleteOrderItem(_orderItem);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			OrderItem.add(event.result);
			_orderItem.dispatchDeleted();
		}
	}
}