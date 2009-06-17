package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PhoneNumberDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class ListPhoneNumberCommand implements ICommand, IResponder	{
		
		public function execute(event:CairngormEvent):void {
			var delegete:PhoneNumberDelegate = new PhoneNumberDelegate(this);
			delegete.listPhoneNumber();
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.setPhoneNumbers(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}