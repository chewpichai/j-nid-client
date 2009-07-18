package com.j_nid.commands {
    
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductTypeDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.ProductType;
	import com.j_nid.utils.CairngormUtils;

	public class ListProductTypeCommand extends RespondCommand	{
	    
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:ProductTypeDelegate = new ProductTypeDelegate(this);
			delegate.listProductType();
		}
		
		override public function result(event:Object):void {
			super.result(event);
			ProductType.add(event.result.children());
			ProductType.loaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}