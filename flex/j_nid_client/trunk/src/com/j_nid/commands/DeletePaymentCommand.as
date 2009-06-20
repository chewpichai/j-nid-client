package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PaymentDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class DeletePaymentCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:PaymentDelegate = new PaymentDelegate(this);
			delegate.deletePayment(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.deletePayment(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}