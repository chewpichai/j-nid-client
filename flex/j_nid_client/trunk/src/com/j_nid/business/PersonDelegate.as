package com.j_nid.business {
	
	import com.j_nid.models.Person;
	import com.j_nid.utils.ServiceUtils;
	import mx.rpc.IResponder;
	
	public class PersonDelegate	{
		
		private var _responder:IResponder;
		
		public function PersonDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		public function listPerson():void {
			ServiceUtils.send("/people/", "GET", _responder);
		}
		
		public function createPerson(person:Person):void {
			ServiceUtils.send("/people/", "POST", _responder, person.toXML());
		}
		
		public function updatePerson(person:Person):void {
			ServiceUtils.send("/people/" + person.id + "/", "PUT", _responder, person.toXML());
		}
	}
}