package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Product;
	import com.j_nid.utils.CairngormUtils;

	public class ListProductCommand extends RespondCommand {
	    
        override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:ProductDelegate = new ProductDelegate(this);
			delegate.listProduct();
		}
		
		override public function result(event:Object):void {
		    super.result(event);
		    Product.add(event.result.children());
		    Product.loaded = true;
		    CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}