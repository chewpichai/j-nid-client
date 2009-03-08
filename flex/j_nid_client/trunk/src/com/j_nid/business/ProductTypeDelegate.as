package com.j_nid.business {
	
	import com.j_nid.models.ProductType;
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
		
		public function createProductType(type:ProductType):void {
			ServiceUtils.send("/producttypes/", "POST", _responder, type.toXML());
		}
		
		public function updateProductType(type:ProductType):void {
			ServiceUtils.send("/producttypes/" + type.id + "/", "PUT", _responder, type.toXML());
		}
	}
}