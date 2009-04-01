package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PaymentDelegate;
	import com.j_nid.models.JNidModelLocator;
	
	import mx.rpc.IResponder;

	public class ListPaymentCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:PaymentDelegate = new PaymentDelegate(this);
			delegate.listPayment();
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.setPayments(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}