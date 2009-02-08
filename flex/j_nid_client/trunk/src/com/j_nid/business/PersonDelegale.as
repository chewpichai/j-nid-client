package com.j_nid.business {
	
	import com.j_nid.utils.ServiceUtils;
	
	import mx.rpc.IResponder;
	
	public class PersonDelegale	{
		
		private var _responder:IResponder;
		
		public function PersonDelegale(responder:IResponder) {
			_responder = responder;
		}
		
		public function listPerson():void {
			ServiceUtils.send("/people/", "GET", _responder);
		}
	}
}