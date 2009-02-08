package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductDelegate;
	import com.j_nid.models.JNidModelLocator;
	import mx.rpc.IResponder;

	public class ListProductCommand implements ICommand, IResponder	{
		
		public function ListProductCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:ProductDelegate = new ProductDelegate(this);
			delegate.listProduct();
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.setProducts(event.result);
		}
		
		public function fault(event:Object):void	{
			
		}
	}
}