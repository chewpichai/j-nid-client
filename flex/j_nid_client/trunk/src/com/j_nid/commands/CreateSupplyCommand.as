package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyDelegate;
	import com.j_nid.utils.ModelUtils;
	import com.j_nid.models.Supply;
	import mx.rpc.IResponder;

	public class CreateSupplyCommand implements ICommand, IResponder	{
		
		public function CreateSupplyCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:SupplyDelegate = new SupplyDelegate(this);
			delegate.createSupply(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.createSupply(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}