package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PersonDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class CreatePersonCommand implements ICommand, IResponder {
		
		public function CreatePersonCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:PersonDelegate = new PersonDelegate(this);
			delegate.createPerson(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.createPerson(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}