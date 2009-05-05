package com.j_nid.models {
    
    import mx.collections.ArrayCollection;
    import mx.collections.IViewCursor;
    import mx.collections.Sort;
    import mx.collections.SortField;
    import mx.events.CollectionEvent;
	
	[Bindable]
	public class Person	extends Model {
		
        private static const GENERAL:uint = 0;
        private static const CUSTOMER:uint = 1;
        private static const SUPPLIER:uint = 2;
        private var _name:String;
    	private var _firstName:String;
    	private var _lastName:String;
    	private var _idCardNumber:String;
        private var _address:String;
        private var _detail1:String;
        private var _detail2:String;
    	private var _outstandingTotal:Number;
    	private var _numOutstandingOrders:int;
    	private var _paidTotal:Number;
    	private var _orderTotal:Number;
    	private var _type:uint;
    	private var _phoneNumbers:ArrayCollection;
    	private var _bankAccounts:ArrayCollection;
    	private var _orders:ArrayCollection;
    	private var _payments:ArrayCollection;
    	private var _supplies:ArrayCollection;
    	private var _transactions:ArrayCollection;
    	    	
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
			idCardNumber = "";
			detail1 = "";
			detail2 = "";
			numOutstandingOrders = 0;
			outstandingTotal = 0;
			paidTotal = 0;
			orderTotal = 0;
			phoneNumbers = new ArrayCollection();
			bankAccounts = new ArrayCollection();
			orders = new ArrayCollection();
			payments = new ArrayCollection();
			supplies = new ArrayCollection();
			transactions = new ArrayCollection();
			orders.addEventListener(CollectionEvent.COLLECTION_CHANGE, orderChangeListener);
		}
		
		private function orderChangeListener(evt:CollectionEvent):void {
			numOutstandingOrders = 0;
			outstandingTotal = 0;
			orderTotal = 0;
			var cursor:IViewCursor = orders.createCursor();
			while (!cursor.afterLast) {
				calcOrder(Order(cursor.current));
				cursor.moveNext();
			}
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
			transactions.addItem(order);
		}
		
		public function removeOrder(order:Order):void {
			order.person = null;
			orders.removeItemAt(orders.getItemIndex(order));
		}
		
		public function addSupply(supply:Supply):void {
			supply.person = this;
			supplies.addItem(supply);
		}
		
		public function removeSupply(supply:Supply):void {
			supply.person = null;
			supplies.removeItemAt(supplies.getItemIndex(supply));
		}
		
		private function calcOrder(order:Order):void {
			var total:Number;
			if (order.isOutstanding) {
				numOutstandingOrders += 1;
			}
			orderTotal += order.total;
			outstandingTotal = paidTotal - orderTotal;
		}
		
		public function addPayment(payment:Payment):void {
			payment.person = this;
			payments.addItem(payment);
			transactions.addItem(payment);
			calcPayment(payment);
		}
		
		private function calcPayment(payment:Payment):void {
			paidTotal += payment.amount;
			outstandingTotal = paidTotal - orderTotal;
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
		
		public function set type(obj:uint):void {
			_type = obj;
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
		
		public function set outstandingTotal(obj:Number):void {
			_outstandingTotal = obj;
		}
		
		public function get outstandingTotal():Number {
			return _outstandingTotal;
		}
		
		public function set numOutstandingOrders(obj:int):void {
			_numOutstandingOrders = obj;
		}
		
		public function get numOutstandingOrders():int {
			return _numOutstandingOrders;
		}
		
		public function set paidTotal(obj:Number):void {
			_paidTotal = obj;
		}
		
		public function get paidTotal():Number {
			return _paidTotal;
		}
		
		public function set orderTotal(obj:Number):void {
			_orderTotal = obj;
		}
		
		public function get orderTotal():Number {
			return _orderTotal;
		}
		
		public function set orders(obj:ArrayCollection):void {
			_orders = obj;
		}
		
		public function get orders():ArrayCollection {
			return _orders;
		}
		
		public function set supplies(obj:ArrayCollection):void {
			_supplies = obj;
		}
		
		public function get supplies():ArrayCollection {
			return _supplies;
		}
		
		public function set payments(obj:ArrayCollection):void {
			_payments = obj;
		}
		
		public function get payments():ArrayCollection {
			return _payments;
		}
		
		public function set transactions(obj:ArrayCollection):void {
			_transactions = obj;
			var sort:Sort = new Sort();
			sort.fields = [new SortField("created", false, true)];
			_transactions.sort = sort;
			_transactions.refresh();
		}
		
		public function get transactions():ArrayCollection {
			return _transactions;
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