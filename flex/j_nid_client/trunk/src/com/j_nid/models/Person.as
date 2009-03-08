package com.j_nid.models {
    
    import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Person	extends Model {
		
        private var _name:String;
    	private var _firstName:String;
    	private var _lastName:String;
    	private var _idCardNumber:String;
        private var _address:String;
        private var _detail1:String;
        private var _detail2:String;
    	private var _outstandingOrderTotal:Number;
    	private var _numOutstandingOrders:int;
    	private var _phoneNumbers:ArrayCollection;
    	private var _bankAccounts:ArrayCollection;
    	private var _orders:ArrayCollection;
    	    	
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
			person.outstandingOrderTotal = obj.outstanding_order_total;
			person.numOutstandingOrders = obj.num_outstanding_orders;
			return person;
    	}
        
		public function Person() {
			super();
			idCardNumber = "";
			detail1 = "";
			detail2 = "";
			phoneNumbers = new ArrayCollection();
			bankAccounts = new ArrayCollection();
			orders = new ArrayCollection();
		}
		
		public function clearPhoneNumbers():void {
			phoneNumbers.removeAll();
		}
		
		public function clearBankAccounts():void {
			bankAccounts.removeAll();
		}
		
		public function addPhoneNumber(phoneNumber:PhoneNumber):void {
			phoneNumber.person = this;
			phoneNumbers.addItem(phoneNumber);
		}
		
		public function addBankAccount(bankAccount:BankAccount):void {
			bankAccount.person = this;
			bankAccounts.addItem(bankAccount);
		}
		
		public function addOrder(order:Order):void {
			order.person = this;
			orders.addItem(order);
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
			return xml;
		}
				
/* ----- get-set function. --------------------------------------------------------------------- */
		
        public function set name(obj:String):void {
			_name = obj;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function set firstName(obj:String):void {
			_firstName = obj;
		}
		
		public function get firstName():String {
			return _firstName;
		}
		
		public function set lastName(obj:String):void {
			_lastName = obj;
		}
		
		public function get lastName():String {
			return _lastName;
		}
		
		public function set idCardNumber(obj:String):void {
			_idCardNumber = obj;
		}
		
		public function get idCardNumber():String {
			return _idCardNumber;
		}
		
		public function set address(obj:String):void {
			_address = obj;
		}
		
		public function get address():String {
			return _address;
		}
		
		public function set detail1(obj:String):void {
			_detail1 = obj;
		}
		
		public function get detail1():String {
			return _detail1;
		}
		
		public function set detail2(obj:String):void {
			_detail2 = obj;
		}
		
		public function get detail2():String {
			return _detail2;
		}
		
		public function set phoneNumbers(obj:ArrayCollection):void {
			_phoneNumbers = obj;
		}
		
		public function get phoneNumbers():ArrayCollection {
			return _phoneNumbers;
		}
		
		public function set bankAccounts(obj:ArrayCollection):void {
			_bankAccounts = obj;
		}
		
		public function get bankAccounts():ArrayCollection {
			return _bankAccounts;
		}
		
		public function set outstandingOrderTotal(obj:Number):void {
			_outstandingOrderTotal = obj;
		}
		
		public function get outstandingOrderTotal():Number {
			return _outstandingOrderTotal;
		}
		
		public function set numOutstandingOrders(obj:int):void {
			_numOutstandingOrders = obj;
		}
		
		public function get numOutstandingOrders():int {
			return _numOutstandingOrders;
		}
		
		public function set orders(obj:ArrayCollection):void {
			_orders = obj;
		}
		
		public function get orders():ArrayCollection {
			return _orders;
		}
	}
}