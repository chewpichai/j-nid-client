package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Supply;
	import com.j_nid.utils.CairngormUtils;
	
	public class ListSupplyCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:SupplyDelegate = new SupplyDelegate(this);
			delegate.listSupply();
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			Supply.add(event.result.children());
			Supply.loaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}