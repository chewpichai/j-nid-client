package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PhoneNumberDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.PhoneNumber;
	import com.j_nid.utils.CairngormUtils;
	
	public class ListPhoneTypeCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegete:PhoneNumberDelegate = new PhoneNumberDelegate(this);
			delegete.listPhoneType();
		}
		
		override public function result(event:Object):void {
			super.result(event);
			PhoneNumber.phoneTypes = event.result.phone_type;
			PhoneNumber.phoneTypeLoaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}