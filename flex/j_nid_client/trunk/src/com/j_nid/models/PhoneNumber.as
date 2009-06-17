package com.j_nid.models {
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
		}
		
		public function toXML():XML {
			var xml:XML = <phone_number/>
			xml.number = number;
			xml.type = type;
			xml.person_id = personID;
			return xml;
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function get person():Person {
			return ModelUtils.getInstance().getPerson(personID);
		}
	}
}