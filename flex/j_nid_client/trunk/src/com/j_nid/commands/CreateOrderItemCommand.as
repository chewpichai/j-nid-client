package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderItemDelegate;
	import com.j_nid.models.JNidModelLocator;
	
	import mx.rpc.IResponder;

	public class CreateOrderItemCommand implements ICommand, IResponder	{
		
		public function CreateOrderItemCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:OrderItemDelegate = new OrderItemDelegate(this);
			delegate.createOrderItem(event.data);
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.createOrderItem(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}