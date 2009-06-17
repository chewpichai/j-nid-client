package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PhoneNumberDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class CreatePhoneNumberCommand implements ICommand, IResponder	{
		
		public function CreatePhoneNumberCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:PhoneNumberDelegate = new PhoneNumberDelegate(this);
			delegate.createPhoneNumber(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.createPhoneNumber(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}