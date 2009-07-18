package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PhoneNumberDelegate;
	import com.j_nid.models.PhoneNumber;

	public class CreatePhoneNumberCommand extends RespondCommand {
	    
	    private var _phoneNumber:PhoneNumber;
	    
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_phoneNumber = event.data;
			var delegate:PhoneNumberDelegate = new PhoneNumberDelegate(this);
			delegate.createPhoneNumber(_phoneNumber);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			PhoneNumber.add(event.result);
			_phoneNumber.dispatchCreated();
		}
	}
}