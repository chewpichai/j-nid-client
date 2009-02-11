package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductDelegate;
	import com.j_nid.models.JNidModelLocator;
	import com.j_nid.models.Product;
	
	import mx.rpc.IResponder;

	public class UpdateProductCommand implements ICommand, IResponder	{
		
		public function UpdateProductCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:ProductDelegate = new ProductDelegate(this);
			delegate.updateProduct(event.data);
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.updateProduct(Product.fromXML(event.result));
		}
		
		public function fault(event:Object):void	{
			
		}
	}
}