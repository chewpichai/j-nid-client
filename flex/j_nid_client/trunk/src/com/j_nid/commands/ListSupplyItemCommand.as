package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyItemDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class ListSupplyItemCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:SupplyItemDelegate = new SupplyItemDelegate(this);
			delegate.listSupplyItem();
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.setSupplyItems(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}