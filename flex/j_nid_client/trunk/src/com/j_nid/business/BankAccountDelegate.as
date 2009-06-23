package com.j_nid.business {
	
	import com.j_nid.models.BankAccount;
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
		
		public function createBankAccount(ba:BankAccount):void {
			ServiceUtils.send("/bankaccounts/", "POST", _responder, ba.toXML());
		}
		
		public function listBankName():void {
			ServiceUtils.send("/banknames/", "GET", _responder);
		}
		
		public function deleteBankAccount(ba:BankAccount):void {
            ServiceUtils.send("/bankaccounts/" + ba.id + "/", "DELETE", _responder);
        }
	}
}