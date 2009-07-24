package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PaymentDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Order;
	import com.j_nid.models.Payment;

	public class CreatePaymentCommand extends RespondCommand {
	    
	    private var _payment:Payment;
		
		override public function execute(event:CairngormEvent):void {
		    super.execute(event);
		    _payment = event.data;
			var delegate:PaymentDelegate = new PaymentDelegate(this);
			delegate.createPayment(_payment);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			createPayment(event.result);
			_payment.dispatchCreated();
		}
		
		private function createPayment(obj:XML):void {
            Payment.add(obj);
            var outStandingOrders:Array = _payment.person.orders.filter(
                function (order:Order, index:int, array:Array):Boolean {
                    return order.isOutstanding;
                }
            );
            var amount:Number = _payment.amount;
            for each (var order:Order in outStandingOrders) {
                var totalToPaid:Number = order.totalToPaid;
                if (totalToPaid > amount) {
                    order.paidTotal += amount;
                } else {
                    order.paidTotal += totalToPaid;
                }
                amount -= totalToPaid;
                order.save();
                if (amount <= 0) {
                    break;
                }
            }
        }
	}
}