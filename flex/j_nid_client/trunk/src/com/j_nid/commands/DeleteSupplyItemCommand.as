package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyItemDelegate;
	import com.j_nid.models.SupplyItem;
	
	public class DeleteSupplyItemCommand extends RespondCommand {
		
		private var _supplyItem:SupplyItem;
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_supplyItem = event.data;
			var delegate:SupplyItemDelegate = new SupplyItemDelegate(this);
			delegate.deleteSupplyItem(_supplyItem);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			SupplyItem.deleteSupplyItem(event.result);
			_supplyItem.dispatchDeleted();
		}
	}
}