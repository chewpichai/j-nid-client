package com.j_nid.models {
    
    import com.j_nid.utils.ModelUtils;
	
	[Bindable]
	public class Person	extends Model {
		
        private static const GENERAL:uint = 0;
        private static const CUSTOMER:uint = 1;
        private static const SUPPLIER:uint = 2;
        
        public var name:String;
    	public var firstName:String;
    	public var lastName:String;
    	public var idCardNumber:String;
        public var address:String;
        public var detail1:String;
        public var detail2:String;
        
        private var _bankAccounts:Array;
        private var _phoneNumbers:Array;
    	private var _type:uint;
    	    	
    	public static function fromXML(obj:XML):Person {
    		var person:Person = new Person();
    		person.id = obj.id;
			person.name = obj.name;
			person.firstName = obj.first_name;
			person.lastName = obj.last_name;
			person.address = obj.address;
			person.idCardNumber = obj.id_card_number;
			person.detail1 = obj.detail1;
			person.detail2 = obj.detail2;
			person.type = obj.type;
			return person;
    	}
        
		public function Person() {
			super();
			name = "";
            firstName = "";
            lastName = "";
            address = "";
            idCardNumber = "";
            detail1 = "";
            detail2 = "";
            type = 0;
		}
		
		public function toXML():XML {
			var xml:XML = <person/>
			xml.name = name;
			xml.first_name = firstName;
			xml.last_name = lastName;
			xml.address = address;
			xml.id_card_number = idCardNumber;
			xml.detail1 = detail1;
			xml.detail2 = detail2;
			xml.type = _type;
			if (_bankAccounts != null && _bankAccounts.length > 0) {
                xml.bank_accounts = <bank_accounts/>
                for each (var account:BankAccount in _bankAccounts) {
                    xml.bank_accounts.appendChild(account.toXML());
                }
            }
            if (_phoneNumbers != null && _phoneNumbers.length > 0) {
                xml.phone_numbers = <phone_numbers/>
                for each (var number:PhoneNumber in _phoneNumbers) {
                    xml.phone_numbers.appendChild(number.toXML());
                }
            }
			return xml;
		}
				
/* ----- get-set function. ------------------------------------------------- */
		
		public function set phoneNumbers(obj:Array):void {
			_phoneNumbers = obj;
		}
		
		public function get phoneNumbers():Array {
			if (id == 0) {
				return _phoneNumbers;
			}
			return ModelUtils.getInstance().getPhoneNumbersByPerson(id);
		}
		
		public function set bankAccounts(obj:Array):void {
            _bankAccounts = obj;
        }
		
		public function get bankAccounts():Array {
			if (id == 0) {
				return _bankAccounts;
			}
			return ModelUtils.getInstance().getBankAccountsByPerson(id);
		}
		
		public function get outstandingTotal():Number {
			return paidTotal - orderTotal;
		}
		
		public function get paidTotal():Number {
			var sum:Number = 0;
			for each (var payment:Payment in payments) {
				sum += payment.amount;
			}
			return sum;
		}
		
		public function get orderTotal():Number {
			var sum:Number = 0;
            for each (var order:Order in orders) {
                sum += order.total;
            }
            return sum;
		}
		
		public function get orders():Array {
			return ModelUtils.getInstance().getOrdersByPerson(id);
		}
		
		public function get supplies():Array {
			return ModelUtils.getInstance().getSuppliesByPerson(id);
		}
		
		public function get payments():Array {
			return ModelUtils.getInstance().getPaymentsByPerson(id);
		}
		
		public function set transactions(obj:Array):void {
			
		}
		
		public function get transactions():Array {
			var transactions:Array = new Array();
			for each (var order:Order in orders) {
				transactions.push(order);
			}
			for each (var payment:Payment in payments) {
				transactions.push(payment);
			}
			transactions.sort(function(first:Object, second:Object):int {
				var firstDate:Date = first.created;
				var secondDate:Date = second.created;
				if (firstDate.time > secondDate.time) {
					return -1;
				} else if (firstDate.time < secondDate.time) {
					return 1;
				} else {
					return 0;
				}
			});
			return transactions;
		}
		
		public function set type(obj:uint):void {
			_type = obj;
		}
		
		public function set isGeneral(obj:Boolean):void {
			if (obj) {
				_type = (int(isSupplier) << SUPPLIER | 
					     1 << GENERAL |
					     int(isCustomer) << CUSTOMER);
			} else {
				_type = (int(isSupplier) << SUPPLIER |
					     int(isCustomer) << CUSTOMER);
			}
		}
		
		public function get isGeneral():Boolean {
			return Boolean(_type & (1 << GENERAL));
		}
		
		public function set isCustomer(obj:Boolean):void {
			if (obj) {
				_type = (int(isSupplier) << SUPPLIER | 
					     1 << CUSTOMER |
					     int(isGeneral) << GENERAL);
			} else {
				_type = (int(isSupplier) << SUPPLIER |
					     int(isGeneral) << GENERAL);
			}
		}
		
		public function get isCustomer():Boolean {
			return Boolean(_type & (1 << CUSTOMER));
		}
		
		public function set isSupplier(obj:Boolean):void {
			if (obj) {
				_type = (int(isCustomer) << CUSTOMER | 
					     1 << SUPPLIER |
					     int(isGeneral) << GENERAL);
			} else {
				_type = (int(isCustomer) << CUSTOMER |
					     int(isGeneral) << GENERAL);
			}
		}
		
		public function get isSupplier():Boolean {
			return Boolean(_type & (1 << SUPPLIER));
		}
	}
}