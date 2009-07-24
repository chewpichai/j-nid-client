package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PaymentDelegate;
	import com.j_nid.models.Order;
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
			deletePayment(event.result);
			_payment.dispatchDeleted();
		}
		
		private function deletePayment(id:uint):void {
		    Payment.deletePayment(id);
		    var outstandingTotal:Number = _payment.person.outstandingTotal;
		    var amount:Number = _payment.amount;
		    if (outstandingTotal < amount) {
		        if (outstandingTotal > 0) {
		            amount -= outstandingTotal;
		        }
                var orders:Array = _payment.person.orders;
                orders.sortOn("created", Array.DESCENDING);
                for each (var order:Order in orders) {
                    var paidTotal:Number = order.paidTotal;
                    order.paidTotal -= amount;
                    amount -= paidTotal;
                    order.save();
                    if (amount <= 0) {
                        break;
                    }
                }
		    }
		}
	}
}