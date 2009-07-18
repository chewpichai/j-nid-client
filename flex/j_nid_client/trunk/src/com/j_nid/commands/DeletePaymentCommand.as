package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PaymentDelegate;
	import com.j_nid.models.Payment;
	
	public class DeletePaymentCommand extends RespondCommand {
		
		private var _payment:Payment;
		
		override public function execute(event:CairngormEvent):void {
		    super.execute(event);
		    _payment = event.data;
			var delegate:PaymentDelegate = new PaymentDelegate(this);
			delegate.deletePayment(_payment);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			Payment.deletePayment(event.result);
			_payment.dispatchDeleted();
		}
	}
}