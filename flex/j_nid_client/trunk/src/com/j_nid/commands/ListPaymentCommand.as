package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PaymentDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Payment;
	import com.j_nid.utils.CairngormUtils;
	
	public class ListPaymentCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:PaymentDelegate = new PaymentDelegate(this);
			delegate.listPayment();
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			Payment.add(event.result.children());
			Payment.loaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}