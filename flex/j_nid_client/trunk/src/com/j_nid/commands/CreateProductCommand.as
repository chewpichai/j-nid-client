package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductDelegate;
	import com.j_nid.utils.ModelUtils;
	import com.j_nid.models.Product;
	import com.j_nid.models.ProductType;
	import mx.rpc.IResponder;

	public class CreateProductCommand implements ICommand, IResponder {
		
		public function CreateProductCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:ProductDelegate = new ProductDelegate(this);
			delegate.createProduct(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.createProduct(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}