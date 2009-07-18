package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyItemDelegate;
	import com.j_nid.models.SupplyItem;
	
	public class CreateSupplyItemCommand extends RespondCommand {

        private var _supplyItems:SupplyItem;

		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_supplyItems = event.data;
			var delegate:SupplyItemDelegate = new SupplyItemDelegate(this);
			delegate.createSupplyItem(_supplyItems);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			SupplyItem.add(event.result);
			_supplyItems.dispatchCreated();
		}
	}
}