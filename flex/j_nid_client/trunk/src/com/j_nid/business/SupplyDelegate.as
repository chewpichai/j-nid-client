package com.j_nid.business {
	
	import com.j_nid.models.Supply;
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class SupplyDelegate {
		
		private var _responder:IResponder;
		
		public function SupplyDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listSupply():void {
			ServiceUtils.send("/supplies/", "GET", _responder);
		}
		
		public function createSupply(supply:Supply):void {
			ServiceUtils.send("/supplies/", "POST", 
				_responder, supply.toXML());
		}
		
		public function updateSupply(supply:Supply):void {
			ServiceUtils.send("/supplies/" + supply.id + "/", 
				"PUT", _responder, supply.toXML());
		}
		
		public function deleteSupply(supply:Supply):void {
			ServiceUtils.send("/supplies/" + supply.id + "/", 
				"DELETE", _responder);
		}
	}
}