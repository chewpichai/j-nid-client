package com.j_nid.models {
	
	[Bindable]
	public class PhoneNumber extends Model {
		
		private var _person:Person;
		private var _number:String;
		private var _type:String;
		
		public static function fromXML(obj:XML):PhoneNumber {
			var phoneNumber:PhoneNumber = new PhoneNumber();
			phoneNumber.id = obj.id;
			phoneNumber.number = obj.number;
			phoneNumber.type = obj.type;
			return phoneNumber;
		}
		
		public function PhoneNumber() {
			super();
		}
		
		public function toXML():XML {
			var xml:XML = <phone_number/>
			xml.number = number;
			xml.type = type;
			return xml;
		}
		
		public function set person(obj:Person):void {
			_person = obj;
		}
		
		public function get person():Person {
			return _person;
		}
		
		public function set number(obj:String):void {
			_number = obj;
		}
		
		public function get number():String {
			return _number;
		}
		
		public function set type(obj:String):void {
			_type = obj;
		}
		
		public function get type():String {
			return _type;
		}
	}
}