package com.j_nid.commands {
    
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductDelegate;
	import com.j_nid.models.Product;
	
	public class UpdateProductCommand extends RespondCommand {
	    
	    private var _product:Product;

		override public function execute(event:CairngormEvent):void {
		    super.execute(event);
		    _product = event.data;
			var delegate:ProductDelegate = new ProductDelegate(this);
			delegate.updateProduct(_product);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			_product.dispatchUpdated();
		}
	}
}