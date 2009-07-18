package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyDelegate;
	import com.j_nid.models.Supply;

	public class DeleteSupplyCommand extends RespondCommand {
		
		private var _supply:Supply;
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_supply = event.data;
			var delegate:SupplyDelegate = new SupplyDelegate(this);
			delegate.deleteSupply(_supply);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			Supply.deleteSupply(event.result);
			_supply.dispatchDeleted();
		}
	}
}