package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SupplyItemDelegate;
	import com.j_nid.models.JNidModelLocator;
	
	import mx.rpc.IResponder;

	public class CreateSupplyItemCommand implements ICommand, IResponder	{
		
		public function CreateSupplyItemCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:SupplyItemDelegate = new SupplyItemDelegate(this);
			delegate.createSupplyItem(event.data);
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.createSupplyItem(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}