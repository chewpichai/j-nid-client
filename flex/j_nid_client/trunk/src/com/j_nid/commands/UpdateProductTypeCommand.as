package com.j_nid.commands {
    
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductTypeDelegate;
	import com.j_nid.models.ProductType;

	public class UpdateProductTypeCommand extends RespondCommand {

		private var _productType:ProductType;
		
		override public function execute(event:CairngormEvent):void {
		    super.execute(event);
		    _productType = event.data;
			var delegate:ProductTypeDelegate = new ProductTypeDelegate(this);
			delegate.updateProductType(_productType);
		}
		
		override public function result(event:Object):void {
			_productType.dispatchUpdated();
		}
	}
}