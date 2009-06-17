package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class UpdateProductCommand implements ICommand, IResponder {
		
		public function UpdateProductCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:ProductDelegate = new ProductDelegate(this);
			delegate.updateProduct(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.updateProduct(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}