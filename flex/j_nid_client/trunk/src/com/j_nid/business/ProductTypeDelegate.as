package com.j_nid.business {
	
	import com.j_nid.utils.ServiceUtils;
	import mx.rpc.IResponder;
	
	public class ProductTypeDelegate {
		
		private var _responder:IResponder;
		
		public function ProductTypeDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listProductType():void {
			ServiceUtils.send("/producttypes/", "GET", _responder);
		}
	}
}