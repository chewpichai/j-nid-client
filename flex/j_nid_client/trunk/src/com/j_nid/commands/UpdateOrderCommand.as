package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.OrderDelegate;
	import com.j_nid.utils.ModelUtils;	
	import mx.rpc.IResponder;

	public class UpdateOrderCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:OrderDelegate = new OrderDelegate(this);
			delegate.updateOrder(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.updateOrder(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}