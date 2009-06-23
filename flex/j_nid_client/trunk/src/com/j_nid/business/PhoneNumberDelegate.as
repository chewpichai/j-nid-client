package com.j_nid.business {
	
	import com.j_nid.models.PhoneNumber;
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class PhoneNumberDelegate {
		
		private var _responder:IResponder;
		
		public function PhoneNumberDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listPhoneNumber():void {
			ServiceUtils.send("/phonenumbers/", "GET", _responder);
		}
		
		public function createPhoneNumber(pn:PhoneNumber):void {
			ServiceUtils.send("/phonenumbers/", "POST", _responder, pn.toXML());
		}
		
		public function listPhoneType():void {
			ServiceUtils.send("/phonetypes/", "GET", _responder);
		}
		
		public function deletePhoneNumber(pn:PhoneNumber):void {
            ServiceUtils.send("/phonenumbers/" + pn.id + "/", "DELETE", _responder);
        }
	}
}