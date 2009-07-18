package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductTypeDelegate;
	import com.j_nid.models.ProductType;

	public class CreateProductTypeCommand extends RespondCommand {
	    
	    private var _productType:ProductType;
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_productType = event.data;
			var delegate:ProductTypeDelegate = new ProductTypeDelegate(this);
			delegate.createProductType(event.data);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			ProductType.add(event.result);
			_productType.dispatchCreated();
		}
	}
}