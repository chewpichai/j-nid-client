package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderDelegate;
	import com.j_nid.utils.ModelUtils;
	import com.j_nid.models.Order;
	import mx.rpc.IResponder;

	public class CreateOrderCommand implements ICommand, IResponder	{
		
		public function CreateOrderCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:OrderDelegate = new OrderDelegate(this);
			delegate.createOrder(event.data);
		}
		
		public function result(event:Object):void {
			ModelUtils.getInstance().createOrder(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}