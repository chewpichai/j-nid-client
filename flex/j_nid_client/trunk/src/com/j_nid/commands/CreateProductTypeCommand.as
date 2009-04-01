package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductTypeDelegate;
	import com.j_nid.models.JNidModelLocator;	
	import mx.rpc.IResponder;

	public class CreateProductTypeCommand implements ICommand, IResponder	{
		
		public function CreateProductTypeCommand() {			
		}
		
		public function execute(event:CairngormEvent):void {
			var delegate:ProductTypeDelegate = new ProductTypeDelegate(this);
			delegate.createProductType(event.data);
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.createProductType(event.result);
		}
		
		public function fault(event:Object):void {
		
		}
	}
}