package com.j_nid.models {
	
	import com.adobe.cairngorm.model.IModelLocator;
	import com.j_nid.controls.EventNames;
	import com.j_nid.utils.CairngormUtils;
	import com.j_nid.utils.PrinterUtils;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.core.Application;

	[Bindable]
	public class JNidModelLocator implements IModelLocator {
		
		private static var modelLocator:JNidModelLocator;
		public static const ALL_TYPE:ProductType = new ProductType(0, "All");
		private var _bankNames:XMLList;
		private var _phoneTypes:XMLList;
		// Array Collection for models.
		private var _productTypes:ArrayCollection;
		private var _products:ArrayCollection;
		private var _people:ArrayCollection;
		private var _bankAccounts:ArrayCollection;
		private var _phoneNumbers:ArrayCollection;
		private var _orders:ArrayCollection;
		private var _orderItems:ArrayCollection;
		private var _payments:ArrayCollection;
		// Map for get object by key.
		private var _productIDMap:Object;
		private var _productTypeIDMap:Object;
		private var _personIDMap:Object;
		private var _personNameMap:Object;
		private var _orderIDMap:Object;
		private var _orderItemIDMap:Object;
		private var _bankAccountIDMap:Object;
		private var _phoneNumberIDMap:Object;
		// Flag for check loaded model.
		private var _loadedProductType:Boolean = false;
		private var _loadedProduct:Boolean = false;
		private var _loadedPerson:Boolean = false;
		private var _loadedOrder:Boolean = false;
		private var _loadedOrderItem:Boolean = false;
		private var _loadedBankAccount:Boolean = false;
		private var _loadedPhoneNumber:Boolean = false;
		private var _loadedPayment:Boolean = false;
		private var _loadedPhoneType:Boolean = false;
		private var _loadedBankName:Boolean = false;		
		// Temporary create object.
		private var _orderToCreate:Order;
		private var _personToCreate:Person;
		
		public function JNidModelLocator() {
			
		}
		
		public static function getInstance():JNidModelLocator {
			if (modelLocator == null) {
				modelLocator = new JNidModelLocator();
			}
			return modelLocator;
		}
		
		public function setProductTypes(obj:XML):void {
			var typeArray:Array = new Array();
			_productTypeIDMap = {};
			for each (var xml:XML in obj.children()) {
				var productType:ProductType = ProductType.fromXML(xml);
				typeArray.push(productType);
				_productTypeIDMap[productType.id] = productType;
			}
			productTypes = new ArrayCollection(typeArray);
			_loadedProductType = true;
			setRelateModels();
		}
		
		public function setProducts(obj:XML):void {
			var productArray:Array = new Array();
			_productIDMap = {};
			for each (var xml:XML in obj.children()) {
				var product:Product = Product.fromXML(xml);
				productArray.push(product);
				_productIDMap[product.id] = product;
			}
			products = new ArrayCollection(productArray);
			_loadedProduct = true;
			setRelateModels();
		}
		
		public function setPeople(obj:XML):void {
			var personArray:Array = new Array();
			_personIDMap = {};
			_personNameMap = {};
			for each (var xml:XML in obj.children()) {
				var person:Person = Person.fromXML(xml);
				personArray.push(person);
				_personIDMap[person.id] = person;
				_personNameMap[person.name] = person;
			}
			people = new ArrayCollection(personArray);
			_loadedPerson = true;
			setRelateModels();
		}
		
		public function setBankAccounts(obj:XML):void {
			var bankAccountArray:Array = new Array();
			for each (var xml:XML in obj.children()) {
				var bankAccount:BankAccount = BankAccount.fromXML(xml);
				bankAccountArray.push(bankAccount);
			}
			bankAccounts = new ArrayCollection(bankAccountArray);
			_loadedBankAccount = true;
			setRelateModels();
		}
		
		public function setPhoneNumbers(obj:XML):void {
			var phoneNumberArray:Array = new Array();
			for each (var xml:XML in obj.children()) {
				var phoneNumber:PhoneNumber = PhoneNumber.fromXML(xml);
				phoneNumberArray.push(phoneNumber);
			}
			phoneNumbers = new ArrayCollection(phoneNumberArray);
			_loadedPhoneNumber = true;
			setRelateModels();
		}
		
		public function setOrders(obj:XML):void {
			var orderArray:Array = new Array();
			_orderIDMap = {};
			for each (var xml:XML in obj.children()) {
				var order:Order = Order.fromXML(xml);
				orderArray.push(order);
				_orderIDMap[order.id] = order;
			}
			orders = new ArrayCollection(orderArray);
			_loadedOrder = true;
			setRelateModels();
		}
		
		public function setOrderItems(obj:XML):void {
			var itemArray:Array = new Array();
			_orderItemIDMap = {};
			for each (var xml:XML in obj.children()) {
				var item:OrderItem = OrderItem.fromXML(xml);
				itemArray.push(item);
				_orderItemIDMap[item.id] = item;
			}
			orderItems = new ArrayCollection(itemArray);
			_loadedOrderItem = true;
			setRelateModels();
		}
		
		public function setPayments(obj:XML):void {
			var paymentArray:Array = new Array();
			for each (var xml:XML in obj.children()) {
				var payment:Payment = Payment.fromXML(xml);
				paymentArray.push(payment);
			}
			payments = new ArrayCollection(paymentArray);
			_loadedPayment = true;
			setRelateModels();
		}
		
		private function setRelateModels():void {
			if (_loadedBankAccount && _loadedOrder && _loadedOrderItem &&
				_loadedPerson && _loadedPhoneNumber && _loadedProduct &&
				_loadedProductType && _loadedPayment) {
					// Set relate for order items.
					var cursor:IViewCursor = orderItems.createCursor();
					while (!cursor.afterLast) {
						var item:OrderItem = OrderItem(cursor.current);
						getOrder(item.orderID).addItem(item);;
						item.product = getProduct(item.productID);;
						cursor.moveNext();
					}
					// Set relate for orders.
					cursor = orders.createCursor();
					while (!cursor.afterLast) {
						var order:Order = Order(cursor.current);
						getPerson(order.personID).addOrder(order);
						cursor.moveNext();
					}
					// Set relate for payments.
					cursor = payments.createCursor();
					while (!cursor.afterLast) {
						var payment:Payment = Payment(cursor.current);
						getPerson(payment.personID).addPayment(payment);
						cursor.moveNext();
					}
					// Set relate for products.
					cursor = products.createCursor();
					while (!cursor.afterLast) {
						var product:Product = Product(cursor.current);
						getProductType(product.typeID).addProduct(product);
						cursor.moveNext();
					}
					// Set relate for bank accounts.
					cursor = bankAccounts.createCursor();
					while (!cursor.afterLast) {
						var bankAccount:BankAccount = BankAccount(cursor.current);
						getPerson(bankAccount.personID).addBankAccount(bankAccount);
						cursor.moveNext();
					}
					// Set relate for bank accounts.
					cursor = phoneNumbers.createCursor();
					while (!cursor.afterLast) {
						var phoneNumber:PhoneNumber = PhoneNumber(cursor.current);
						getPerson(phoneNumber.personID).addPhoneNumber(phoneNumber);
						cursor.moveNext();
					}
					sortModels();
				}
		}
		
		public function sortModels():void {
			// Add sort for people.
			var sort:Sort = new Sort();
			sort.fields = [new SortField("name")]
			people.sort = sort;
			people.refresh();
			// Add sort for productTypes.
			sort = new Sort();
			sort.fields = [new SortField("name")]
			productTypes.sort = sort;
			productTypes.refresh();
			// Add sort for products.
			sort = new Sort();
			sort.fields = [new SortField("type"), new SortField("name")];
			products.sort = sort;
			products.refresh();
			// Add sort for orders.
			sort = new Sort();
			sort.fields = [new SortField("created", false, true)];
			orders.sort = sort;
			orders.refresh();
		}
		
		public function createOrder(obj:XML):void {
			var order:Order = Order.fromXML(obj);
			_orderIDMap[order.id] = order;
			var person:Person = getPerson(order.personID);
			person.addOrder(order);
			for each (var item:OrderItem in _orderToCreate.orderItems) {
				item.orderID = order.id;
				CairngormUtils.dispatchEvent(EventNames.CREATE_ORDER_ITEM, item);
			}
			orders.addItem(order);
		}
		
		public function createOrderItem(obj:XML):void {
			var item:OrderItem = OrderItem.fromXML(obj);
			_orderItemIDMap[item.id] = item;
			item.product = getProduct(item.productID);
			getOrder(item.orderID).addItem(item);
			orderItems.addItem(item);
			if (item.order.orderItems.length == _orderToCreate.orderItems.length) {
				PrinterUtils.printOrder(item.order);
				Application.application.setPage("paymentPage");
			}
		}
		
		public function createPerson(obj:XML):void {
			var person:Person = Person.fromXML(obj);
			_personIDMap[person.id] = person;
			_personNameMap[person.name] = person;
			for each (var bankAccount:BankAccount in _personToCreate.bankAccounts) {
				bankAccount.personID = person.id;
				CairngormUtils.dispatchEvent(EventNames.CREATE_BANK_ACCOUNT, bankAccount);
			}
			for each (var phoneNumber:PhoneNumber in _personToCreate.phoneNumbers) {
				phoneNumber.personID = person.id;
				CairngormUtils.dispatchEvent(EventNames.CREATE_PHONE_NUMBER, phoneNumber);
			}
			people.addItem(person);
		}
		
		public function createBankAccount(obj:XML):void {
			var bankAccount:BankAccount = BankAccount.fromXML(obj);
			_bankAccountIDMap[bankAccount.id] = bankAccount;
			getPerson(bankAccount.personID).addBankAccount(bankAccount);
			bankAccounts.addItem(bankAccount);
		}
		
		public function createPhoneNumber(obj:XML):void {
			var phoneNumber:PhoneNumber = PhoneNumber.fromXML(obj);
			_phoneNumberIDMap[phoneNumber.id] = phoneNumber;
			getPerson(phoneNumber.personID).addPhoneNumber(phoneNumber);
			phoneNumbers.addItem(phoneNumber);
		}
		
		public function createProductType(obj:XML):void {
			var productType:ProductType = ProductType.fromXML(obj);
			_productTypeIDMap[productType.id] = productType;
			productTypes.addItem(productType);
		}
		
		public function createProduct(obj:XML):void {
			var product:Product = Product.fromXML(obj);
			_productIDMap[product.id] = product;
			getProductType(product.typeID).addProduct(product);
			products.addItem(product);
		}
		
		public function createPayment(obj:XML):void {
			var payment:Payment = Payment.fromXML(obj);
			getPerson(payment.personID).addPayment(payment);
			payments.addItem(payment);
		}
		
		public function getProductType(id:int):ProductType {
			if (_productTypeIDMap == null) {
				return null
			}
			return _productTypeIDMap[id];
		}
		
		public function getPerson(id:int):Person {
			if (_personIDMap == null) {
				return null
			}
			return _personIDMap[id];
		}
		
		public function updateProduct(xml:XML):void {
			// For trigger data binding.
			products.refresh();
		}
		
		public function getPersonByName(name:String):Person {
			if (_personNameMap == null) {
				return null;
			}
			return _personNameMap[name];
		}
		
		public function getOrder(id:int):Order {
			if (_orderIDMap == null) {
				return null;
			}
			return _orderIDMap[id];
		}
		
		public function getOrderItem(id:int):OrderItem {
			if (_orderItemIDMap == null) {
				return null;
			}
			return _orderItemIDMap[id];
		}
		
		public function getProduct(id:int):Product {
			if (_productIDMap == null) {
				return null;
			}
			return _productIDMap[id];
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set productTypes(obj:ArrayCollection):void {
			_productTypes = obj;
		}
		
		public function get productTypes():ArrayCollection {
			return _productTypes;
		}
		
		public function set products(obj:ArrayCollection):void {
			_products = obj;
		}
		
		public function get products():ArrayCollection {
			return _products;
		}
		
		public function set people(obj:ArrayCollection):void {
			_people = obj;
		}
		
		public function get people():ArrayCollection {
			return _people;
		}
		
		public function set bankAccounts(obj:ArrayCollection):void {
			_bankAccounts = obj;
		}
		
		public function get bankAccounts():ArrayCollection {
			return _bankAccounts;
		}
		
		public function set phoneNumbers(obj:ArrayCollection):void {
			_phoneNumbers = obj;
		}
		
		public function get phoneNumbers():ArrayCollection {
			return _phoneNumbers;
		}
		
		public function set orders(obj:ArrayCollection):void {
			_orders = obj;
		}
		
		public function get orders():ArrayCollection {
			return _orders;
		}
		
		public function set orderItems(obj:ArrayCollection):void {
			_orderItems = obj;
		}
		
		public function get orderItems():ArrayCollection {
			return _orderItems;
		}
		
		public function set orderToCreate(obj:Order):void {
			_orderToCreate = obj;
		}
		
		public function get payments():ArrayCollection {
			return _payments;
		}
		
		public function set payments(obj:ArrayCollection):void {
			_payments = obj;
		}
		
		public function get bankNames():XMLList {
			return _bankNames;
		}
		
		public function set bankNames(obj:XMLList):void {
			_bankNames = obj;
			_loadedBankName = true;
		}
		
		public function get phoneTypes():XMLList {
			return _phoneTypes;
		}
		
		public function set phoneTypes(obj:XMLList):void {
			_phoneTypes = obj;
			_loadedPhoneType = true;
		}
		
		public function set personToCreate(obj:Person):void {
			_personToCreate = obj;
		}
	}
}