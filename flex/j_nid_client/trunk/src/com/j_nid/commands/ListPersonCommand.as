package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PersonDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.Person;
	import com.j_nid.utils.CairngormUtils;

	public class ListPersonCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:PersonDelegate = new PersonDelegate(this);
			delegate.listPerson();
		}
		
		override public function result(event:Object):void {
			super.result(event);
			Person.add(event.result.children());
			Person.loaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}