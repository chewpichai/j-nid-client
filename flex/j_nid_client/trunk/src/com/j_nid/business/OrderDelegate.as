package com.j_nid.business {
	
	import com.j_nid.models.Order;
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class OrderDelegate {
		
		private var _responder:IResponder;
		
		public function OrderDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listOrder():void {
			ServiceUtils.send("/orders/", "GET", _responder);
		}
		
		public function createOrder(order:Order):void {
			ServiceUtils.send("/orders/", "POST", _responder, order.toXML());
		}
		
		public function updateOrder(order:Order):void {
			ServiceUtils.send("/orders/" + order.id + "/", "PUT", _responder, order.toXML());
		}
	}
}