package com.j_nid.business {
	
	import com.j_nid.models.SupplyItem;
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class SupplyItemDelegate {
		
		private var _responder:IResponder;
		
		public function SupplyItemDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listSupplyItem():void {
			ServiceUtils.send("/supplyitems/", "GET", _responder);
		}
		
		public function createSupplyItem(item:SupplyItem):void {
			ServiceUtils.send("/supplyitems/", "POST", _responder, item.toXML());
		}
		
		public function deleteSupplyItem(item:SupplyItem):void {
			ServiceUtils.send("/supplyitems/" + item.id + "/", "DELETE", _responder);
		}
	}
}