package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PersonDelegale;
	import com.j_nid.models.JNidModelLocator;
	
	import mx.rpc.IResponder;

	public class ListPersonCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:PersonDelegale = new PersonDelegale(this);
			delegate.listPerson();
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.setPeople(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}