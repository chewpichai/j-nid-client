package com.j_nid.models {
    
	import com.j_nid.events.JNidEvent;
	
	[Event(name="bankAccountCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="bankAccountDeleted", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class BankAccount extends Model {
		
		private static var _bankAccounts:Array = [];
		private static var _idMap:Object = {};
		public static var bankNames:XMLList;
		public static var loaded:Boolean = false;
		public static var bankNameLoaded:Boolean = false;
		
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
		
		public static function all():Array {
		    return _bankAccounts;
		}
		
		public static function add(obj:Object):void {
		    if (obj is XML) {
                obj = fromXML(XML(obj));
            } else if (obj is XMLList) {
                for each (var xml:XML in obj) {
                    add(xml);
                }
                return;
            }
            _bankAccounts.push(obj);
            _idMap[obj.id] = obj;
		}
		
		public static function getByID(obj:int):BankAccount {
            return _idMap[obj];
        }
        
        public static function filterByPerson(personID:uint):Array {
            return _bankAccounts.filter(
                        function(ba:BankAccount, index:int, arr:Array):Boolean {
                            return ba.personID == personID;
                        });
        }
        
        public static function deleteBankAccount(obj:uint):void {
            var bankAccount:BankAccount = getByID(obj);
            _bankAccounts.splice(_bankAccounts.indexOf(bankAccount), 1);
            delete _idMap[bankAccount.id];
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
			return Person.getByID(personID);
		}
	}
}