package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PersonDelegate;
	import com.j_nid.models.Person;

	public class UpdatePersonCommand extends RespondCommand {
	    
	    private var _person:Person;

		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_person = event.data;
			var delegate:PersonDelegate = new PersonDelegate(this);
			delegate.updatePerson(_person);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			Person.add(event.result);
            _person.dispatchUpdated();
		}
	}
}