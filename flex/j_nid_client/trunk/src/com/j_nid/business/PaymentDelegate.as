package com.j_nid.business {
	
	import com.j_nid.models.Payment;
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class PaymentDelegate {
		
		private var _responder:IResponder;
		
		public function PaymentDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listPayment():void {
			ServiceUtils.send("/payments/", "GET", _responder);
		}
		
		public function createPayment(payment:Payment):void {
			ServiceUtils.send("/payments/", "POST", _responder, payment.toXML());
		}
	}
}