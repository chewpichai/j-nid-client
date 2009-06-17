package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PhoneNumberDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class ListPhoneTypeCommand implements ICommand, IResponder	{
		
		public function execute(event:CairngormEvent):void {
			var delegete:PhoneNumberDelegate = new PhoneNumberDelegate(this);
			delegete.listPhoneType();
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.phoneTypes = event.result.phone_type;
		}
		
		public function fault(event:Object):void {
			
		}
	}
}