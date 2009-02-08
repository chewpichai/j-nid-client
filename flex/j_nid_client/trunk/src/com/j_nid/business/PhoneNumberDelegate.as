package com.j_nid.business {
	
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
	}
}