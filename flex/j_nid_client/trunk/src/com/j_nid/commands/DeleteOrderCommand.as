package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderDelegate;
	import com.j_nid.models.JNidModelLocator;
	
	import mx.rpc.IResponder;

	public class DeleteOrderCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:OrderDelegate = new OrderDelegate(this);
			delegate.deleteOrder(event.data);
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.deleteOrder(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}