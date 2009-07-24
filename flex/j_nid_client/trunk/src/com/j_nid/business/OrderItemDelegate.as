package com.j_nid.business {
	
	import com.j_nid.models.OrderItem;
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class OrderItemDelegate {
		
		private var _responder:IResponder;
		
		public function OrderItemDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listOrderItem():void {
			ServiceUtils.send("/orderitems/", "GET", _responder);
		}
		
		public function createOrderItem(item:OrderItem):void {
			ServiceUtils.send("/orderitems/", "POST", _responder, item.toXML());
		}
		
		public function updateOrderItem(item:OrderItem):void {
            ServiceUtils.send("/orderitems/" + item.id + "/", "PUT", _responder, item.toXML());
        }
		
		public function deleteOrderItem(item:OrderItem):void {
			ServiceUtils.send("/orderitems/" + item.id + "/", "DELETE", _responder);
		}
	}
}