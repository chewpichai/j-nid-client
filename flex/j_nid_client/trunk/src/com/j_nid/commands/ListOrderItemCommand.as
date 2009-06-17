package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderItemDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class ListOrderItemCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:OrderItemDelegate = new OrderItemDelegate(this);
			delegate.listOrderItem();
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.setOrderItems(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}