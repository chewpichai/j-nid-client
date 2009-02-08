package com.j_nid.business {
	
	import com.j_nid.utils.ServiceUtils;
	import mx.rpc.IResponder;
	
	public class BankAccountDelegate {
		
		private var _responder:IResponder;
		
		public function BankAccountDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listBankAccount():void {
			ServiceUtils.send("/bankaccounts/", "GET", _responder);
		}
	}
}