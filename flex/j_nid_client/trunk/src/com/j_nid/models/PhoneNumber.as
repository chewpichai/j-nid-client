package com.j_nid.models {
	import com.j_nid.events.JNidEvent;
	import com.j_nid.utils.ModelUtils;
	
	
	[Bindable]
	public class PhoneNumber extends Model {
		
		public var personID:uint;
		public var number:String;
		public var type:String;
		
		public static function fromXML(obj:XML):PhoneNumber {
			var phoneNumber:PhoneNumber = new PhoneNumber();
			phoneNumber.id = obj.id;
			phoneNumber.personID = obj.person_id;
			phoneNumber.number = obj.number;
			phoneNumber.type = obj.type;
			return phoneNumber;
		}
		
		public function PhoneNumber() {
			super();
			personID = 0;
			number = "";
			type = "";
			//
            createEvent = JNidEvent.CREATE_PHONE_NUMBER;
            updateEvent = JNidEvent.UPDATE_PHONE_NUMBER;
            deleteEvent = JNidEvent.DELETE_PHONE_NUMBER;
		}
		
		public function toXML():XML {
			var xml:XML = <phone_number/>
			xml.number = number;
			xml.type = type;
			xml.person_id = personID;
			return xml;
		}
		
		override public function toString():String {
			return number;
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function set person(obj:Person):void {
			personID = obj.id;
		}
		
		public function get person():Person {
			return ModelUtils.getInstance().getPerson(personID);
		}
	}
}