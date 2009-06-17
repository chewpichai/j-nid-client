package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyItemDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class DeleteSupplyItemCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:SupplyItemDelegate = new SupplyItemDelegate(this);
			delegate.deleteSupplyItem(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.deleteSupplyItem(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}