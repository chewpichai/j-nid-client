package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Supply;
	import com.j_nid.models.SupplyItem;
	import com.j_nid.utils.CairngormUtils;
	
	public class CreateSupplyCommand extends RespondCommand {
	    
	    private var _supply:Supply;

		override public function execute(event:CairngormEvent):void {
		    super.execute(event);
		    _supply = event.data;
			var delegate:SupplyDelegate = new SupplyDelegate(this);
			delegate.createSupply(_supply);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			createSupply(event.result);
			_supply.dispatchCreated();
		}
		
		private function createSupply(obj:XML):void {
            Supply.add(obj);
            for each (var item:XML in obj.supply_items.supply_item) {
                SupplyItem.add(item);
            }
            CairngormUtils.dispatchEvent(JNidEvent.SUPPLY_CREATED, _supply);
        }
	}
}