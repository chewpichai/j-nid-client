package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.ProductTypeDelegate;
	import com.j_nid.utils.ModelUtils;
	
	import mx.rpc.IResponder;

	public class UpdateProductTypeCommand implements ICommand, IResponder {
		
		public function UpdateProductTypeCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:ProductTypeDelegate = new ProductTypeDelegate(this);
			delegate.updateProductType(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.updateProductType(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}