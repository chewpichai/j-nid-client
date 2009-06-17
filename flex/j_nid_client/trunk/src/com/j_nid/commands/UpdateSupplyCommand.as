package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyDelegate;
	import com.j_nid.utils.ModelUtils;	
	import mx.rpc.IResponder;

	public class UpdateSupplyCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:SupplyDelegate = new SupplyDelegate(this);
			delegate.updateSupply(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.updateSupply(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}