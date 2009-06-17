package com.j_nid.models {
	import com.j_nid.utils.ModelUtils;
	
	
	[Bindable]
	public class BankAccount extends Model {
		
		public var personID:uint;
		public var number:String;
		public var bank:String;
		
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
			personID = 0;
			number = "";
			bank = "";
		}
		
		public function toXML():XML {
			var xml:XML = <bank_account/>
			xml.number = number;
			xml.bank = bank;
			xml.person_id = personID;
			return xml;
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function get person():Person {
			return ModelUtils.getInstance().getPerson(personID);
		}
	}
}