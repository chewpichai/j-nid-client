package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Order;
	import com.j_nid.models.OrderItem;
	import com.j_nid.models.Payment;
	import com.j_nid.utils.CairngormUtils;
	
	public class CreateOrderCommand extends RespondCommand	{
		
		private var _order:Order;
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_order = event.data;
			var delegate:OrderDelegate = new OrderDelegate(this);
			delegate.createOrder(_order);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			createOrder(event.result);
			_order.dispatchCreated();
		}
		
		private function createOrder(obj:XML):void {
            Order.add(obj);
            for each (var item:XML in obj.order_items.order_item) {
                OrderItem.add(item);
            }
            // Create payment.
            if (_order.paidTotal > 0) {
                var payment:Payment = new Payment();
                payment.amount = _order.paidTotal;
                payment.personID = _order.personID;
                CairngormUtils.dispatchEvent(JNidEvent.CREATE_PAYMENT,
                    payment);
            }
            CairngormUtils.dispatchEvent(JNidEvent.ORDER_CREATED, _order);
        }
	}
}