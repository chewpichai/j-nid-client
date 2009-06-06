package com.j_nid.models {
	
	[Bindable]
	public class Payment extends Model {
		
		private var _person:Person;
		private var _personID:int;
		private var _amount:Number;
		private var _notation:String;
		private var _created:Date;
		
		public static function fromXML(obj:XML):Payment {
    		var payment:Payment = new Payment();
    		payment.id = obj.id;
    		payment.personID = obj.person_id;
    		payment.amount = obj.amount;
    		payment.notation = obj.notation;
    		payment.created = new Date(Date.parse(obj.created));
			return payment;
    	}
		
		public function Payment() {
			super();
			amount = 0;
			notation = "";
			created = new Date();
		}
		
		public function toXML():XML {
			var xml:XML = <payment/>;
			xml.person_id = personID;
			xml.amount = amount;
			xml.notation = notation;
			xml.created = created;
			return xml;
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */

		public function set person(obj:Person):void {
			_person = obj;
			_personID = obj.id;
		}
		
		public function get person():Person {
			return _person;
		}
		
		public function set personID(obj:int):void {
			_personID = obj;
		}
		
		public function get personID():int {
			return _personID;
		}
		
		public function set amount(obj:Number):void {
			_amount = obj;
		}
		
		public function get amount():Number {
			return _amount;
		}
		
		public function set notation(obj:String):void {
			_notation = obj;
		}
		
		public function get notation():String {
			return _notation;
		}
		
		public function set created(obj:Date):void {
			_created = obj;
		}
		
		public function get created():Date {
			return _created;
		}
	}
}