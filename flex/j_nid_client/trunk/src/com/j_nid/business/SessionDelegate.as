package com.j_nid.business {
	
	import com.j_nid.utils.ServiceUtils;
	import mx.rpc.IResponder;
	
	public class SessionDelegate {
		
		private var _responder:IResponder;
		
		public function SessionDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function logIn(obj:Object):void {
			var xml:XML = <user/>;
			xml.username = obj.username;
			xml.password = obj.password;
			ServiceUtils.send("/sessions/", "POST", _responder, xml);
		}
		
		public function logOut():void {
			ServiceUtils.send("/sessions/", "DELETE", _responder);
		}
	}
}