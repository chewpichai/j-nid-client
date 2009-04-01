package com.j_nid.models {
	
	[Bindable]
	public class BankAccount extends Model {
		
		private var _person:Person;
		private var _personID:int;
		private var _number:String;
		private var _bank:String;
		
		public static function fromXML(obj:XML):BankAccount {
			var bankAccount:BankAccount = new BankAccount();
			bankAccount.id = obj.id;
			bankAccount.personID = obj.person_id;
			bankAccount.number = obj.number;
			bankAccount.bank = obj.bank;
			return bankAccount;
		}
		
		public function BankAccount() {
			super();
		}
		
		public function toXML():XML {
			var xml:XML = <bank_account/>
			xml.number = number;
			xml.bank = bank;
			xml.person_id = personID;
			return xml;
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set person(obj:Person):void {
			_person = obj;
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
		
		public function set number(obj:String):void {
			_number = obj;
		}
		
		public function get number():String {
			return _number;
		}
		
		public function set bank(obj:String):void {
			_bank = obj;
		}
		
		public function get bank():String {
			return _bank;
		}
	}
}