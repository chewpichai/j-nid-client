package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PhoneNumberDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class DeletePhoneNumberCommand implements ICommand, IResponder {

		public function execute(event:CairngormEvent):void {
			var delegate:PhoneNumberDelegate = new PhoneNumberDelegate(this);
			delegate.deletePhoneNumber(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.deletePhoneNumber(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}