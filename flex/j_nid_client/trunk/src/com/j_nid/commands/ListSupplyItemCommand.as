package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyItemDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.SupplyItem;
	import com.j_nid.utils.CairngormUtils;

	public class ListSupplyItemCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:SupplyItemDelegate = new SupplyItemDelegate(this);
			delegate.listSupplyItem();
		}
		
		override public function result(event:Object):void {
			super.result(event);
			SupplyItem.add(event.result.children());
			SupplyItem.loaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}