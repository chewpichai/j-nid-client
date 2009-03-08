package com.j_nid.business {
	
	import com.j_nid.models.Product;
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class ProductDelegate {
		
		private var _responder:IResponder;
		
		public function ProductDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listProduct():void {
			ServiceUtils.send("/products/", "GET", _responder);
		}
		
		public function createProduct(product:Product):void {
			ServiceUtils.send("/products/", "POST", _responder, product.toXML());
		}
		
		public function updateProduct(product:Product):void {
			ServiceUtils.send("/products/" + product.id + "/", "PUT", _responder, product.toXML());
		}
	}
}