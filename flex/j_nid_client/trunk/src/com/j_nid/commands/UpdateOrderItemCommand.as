package com.j_nid.commands {
    
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderItemDelegate;
	import com.j_nid.models.OrderItem;
	
	public class UpdateOrderItemCommand extends RespondCommand {
	    
	    private var _item:OrderItem;

		override public function execute(event:CairngormEvent):void {
		    super.execute(event);
		    _item = event.data;
			var delegate:OrderItemDelegate = new OrderItemDelegate(this);
			delegate.updateOrderItem(_item);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			_item.dispatchUpdated();
		}
	}
}