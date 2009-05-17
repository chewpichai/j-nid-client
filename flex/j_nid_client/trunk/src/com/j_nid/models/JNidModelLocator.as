package com.j_nid.models {
	
	import com.adobe.cairngorm.model.IModelLocator;
	import com.j_nid.controls.EventNames;
	import com.j_nid.utils.CairngormUtils;
	import com.j_nid.utils.PrintUtils;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.core.Application;
	import mx.resources.ResourceManager;
	import mx.resources.IResourceManager;
	
	[ResourceBundle("ProductPage")]
	[Bindable]
	public class JNidModelLocator implements IModelLocator {
		
		private static var resourceManager:IResourceManager = 
			ResourceManager.getInstance();
		private static var modelLocator:JNidModelLocator;
		public static const ALL_TYPE:ProductType = 
			new ProductType(0, resourceManager.getString('ProductPage', 'All'));
		private var _bankNames:XMLList;
		private var _phoneTypes:XMLList;
		// Array Collection for models.
		private var _productTypesWithAll:ArrayCollection;
		private var _productTypes:ArrayCollection;
		private var _products:ArrayCollection;
		private var _people:ArrayCollection;
		private var _bankAccounts:ArrayCollection;
		private var _phoneNumbers:ArrayCollection;
		private var _orders:ArrayCollection;
		private var _orderItems:ArrayCollection;
		private var _payments:ArrayCollection;
		private var _supplies:ArrayCollection;
		private var _supplyItems:ArrayCollection;
		// Map for get object by key.
		private var _productIDMap:Object;
		private var _productTypeIDMap:Object;
		private var _personIDMap:Object;
		private var _personNameMap:Object;
		private var _orderIDMap:Object;
		private var _orderItemIDMap:Object;
		private var _bankAccountIDMap:Object;
		private var _phoneNumberIDMap:Object;
		private var _supplyIDMap:Object;
		private var _supplyItemIDMap:Object;
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
		private var _loadedSupply:Boolean = false;
		private var _loadedSupplyItem:Boolean = false;
		// Temporary create object.
		public var orderToCreate:Order;
		public var supplyToCreate:Supply;
		public var personToCreate:Person;
		
		public function JNidModelLocator() {
			_productIDMap = new Object();
			_productTypeIDMap = new Object();
			_personIDMap = new Object();
			_personNameMap = new Object();
			_orderIDMap = new Object();
			_orderItemIDMap = new Object();
			_bankAccountIDMap = new Object();
			_phoneNumberIDMap = new Object();
			_supplyIDMap = new Object();
			_supplyItemIDMap = new Object();
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
			var typeWithAll:Array = typeArray.slice();
			typeWithAll.unshift(ALL_TYPE);
			productTypesWithAll = new ArrayCollection(typeWithAll);
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
		
		public function setSupplies(obj:XML):void {
			var supplyArray:Array = new Array();
			_supplyIDMap = {};
			for each (var xml:XML in obj.children()) {
				var supply:Supply = Supply.fromXML(xml);
				supplyArray.push(supply);
				_supplyIDMap[supply.id] = supply;
			}
			supplies = new ArrayCollection(supplyArray);
			_loadedSupply = true;
			setRelateModels();
		}
		
		public function setSupplyItems(obj:XML):void {
			var itemArray:Array = new Array();
			_supplyItemIDMap = {};
			for each (var xml:XML in obj.children()) {
				var item:SupplyItem = SupplyItem.fromXML(xml);
				itemArray.push(item);
				_supplyItemIDMap[item.id] = item;
			}
			supplyItems = new ArrayCollection(itemArray);
			_loadedSupplyItem = true;
			setRelateModels();
		}
		
		private function setRelateModels():void {
			if (_loadedBankAccount && _loadedOrder && _loadedOrderItem &&
				_loadedPerson && _loadedPhoneNumber && _loadedProduct &&
				_loadedProductType && _loadedPayment && _loadedSupply &&
				_loadedSupplyItem) {
					// Set relate for payments.
					var cursor:IViewCursor = payments.createCursor();
					while (!cursor.afterLast) {
						var payment:Payment = Payment(cursor.current);
						getPerson(payment.personID).addPayment(payment);
						cursor.moveNext();
					}
					// Set relate for order items.
					cursor = orderItems.createCursor();
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
					cursor = supplyItems.createCursor();
					while (!cursor.afterLast) {
						var supplyItem:SupplyItem = SupplyItem(cursor.current);
						getSupply(supplyItem.supplyID).addItem(supplyItem);
						supplyItem.product = getProduct(supplyItem.productID);
						cursor.moveNext();
					}
					// Set relate for orders.
					cursor = supplies.createCursor();
					while (!cursor.afterLast) {
						var supply:Supply = Supply(cursor.current);
						getPerson(supply.personID).addSupply(supply);
						cursor.moveNext();
					}
					Application.application.currentState = null;
				}
		}
		
		public function createOrder(obj:XML):void {
			var order:Order = Order.fromXML(obj);
			_orderIDMap[order.id] = order;
			var person:Person = getPerson(order.personID);
			person.addOrder(order);
			for each (var item:OrderItem in orderToCreate.orderItems) {
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
			if (item.order.orderItems.length == orderToCreate.orderItems.length) {
				PrintUtils.printOrder(item.order);
				// For cash customer create payment.
				if (item.order.personID <= 24) {
					var payment:Payment = new Payment();
					payment.amount = item.order.total;
					payment.person = item.order.person;
					CairngormUtils.dispatchEvent(EventNames.CREATE_PAYMENT, payment);
				}
				Application.application.setPage("paymentPage");
				Application.application.paymentPage.setPerson(orderToCreate.person);
			}
		}
		
		public function createSupply(obj:XML):void {
			var supply:Supply = Supply.fromXML(obj);
			_supplyIDMap[supply.id] = supply;
			var person:Person = getPerson(supply.personID);
			person.addSupply(supply);
			for each (var item:SupplyItem in supplyToCreate.supplyItems) {
				item.supplyID = supply.id;
				CairngormUtils.dispatchEvent(EventNames.CREATE_SUPPLY_ITEM, item);
			}
			supplies.addItem(supply);
		}
		
		public function createSupplyItem(obj:XML):void {
			var item:SupplyItem = SupplyItem.fromXML(obj);
			_supplyItemIDMap[item.id] = item;
			item.product = getProduct(item.productID);
			getSupply(item.supplyID).addItem(item);
			supplyItems.addItem(item);
			if (item.supply.supplyItems.length == supplyToCreate.supplyItems.length) {
				Application.application.setPage("mainPage");
			}
		}
		
		public function createPerson(obj:XML):void {
			var person:Person = Person.fromXML(obj);
			_personIDMap[person.id] = person;
			_personNameMap[person.name] = person;
			for each (var bankAccount:BankAccount in personToCreate.bankAccounts) {
				bankAccount.personID = person.id;
				CairngormUtils.dispatchEvent(EventNames.CREATE_BANK_ACCOUNT, bankAccount);
			}
			for each (var phoneNumber:PhoneNumber in personToCreate.phoneNumbers) {
				phoneNumber.personID = person.id;
				CairngormUtils.dispatchEvent(EventNames.CREATE_PHONE_NUMBER, phoneNumber);
			}
			people.addItem(person);
			Application.application.personPage.closeForm();
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
			productTypesWithAll.addItem(productType);
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
			var outStandingOrders:Array = payment.person.orders.source.filter(
				function (order:*, index:int, array:Array):Boolean {
					return order.isOutstanding;
				}
			);
			var amount:Number = payment.amount;
			for each (var order:Order in outStandingOrders) {
				if (order.totalToPaid > amount) {
					order.paidTotal += amount;
				} else {
					order.paidTotal += order.totalToPaid;
				}
				amount -= order.totalToPaid;
				CairngormUtils.dispatchEvent(EventNames.UPDATE_ORDER, order);
				if (amount <= 0) {
					break;
				}
			}
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
		
		public function getSupply(id:int):Supply {
			if (_supplyIDMap == null) {
				return null
			}
			return _supplyIDMap[id];
		}
		
		public function updateProduct(xml:XML):void {
			
		}
		
		public function updateProductType(xml:XML):void {
			
		}
		
		public function updateOrder(xml:XML):void {
			
		}
		
		public function deleteOrder(xml:XML):void {
			
		}
		
		public function deleteOrderItem(xml:XML):void {
			
		}
		
		public function updateSupply(xml:XML):void {
			
		}
		
		public function deleteSupply(xml:XML):void {
			
		}
		
		public function deleteSupplyItem(xml:XML):void {
			
		}
		
		public function removeOrder(order:Order):void {
			order.person.removeOrder(order);
			orders.removeItemAt(orders.getItemIndex(order));
			for each (var item:OrderItem in order.orderItems) {
				removeOrderItem(item);
			}
			delete _orderIDMap[order.id];
		}
		
		public function removeOrderItem(item:OrderItem):void {
			orderItems.removeItemAt(orderItems.getItemIndex(item));
			delete _orderItemIDMap[item.id];
		}
		
		public function removeSupply(supply:Supply):void {
			supply.person.removeSupply(supply);
			supplies.removeItemAt(supplies.getItemIndex(supply));
			for each (var item:SupplyItem in supply.supplyItems) {
				removeSupplyItem(item);
			}
			delete _supplyIDMap[supply.id];
		}
		
		public function removeSupplyItem(item:SupplyItem):void {
			supplyItems.removeItemAt(supplyItems.getItemIndex(item));
			delete _supplyItemIDMap[item.id];
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
		
		public function set productTypesWithAll(obj:ArrayCollection):void {
			_productTypesWithAll = obj;
		}
		
		public function get productTypesWithAll():ArrayCollection {
			return _productTypesWithAll;
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
		
		public function set supplies(obj:ArrayCollection):void {
			_supplies = obj;
		}
		
		public function get supplies():ArrayCollection {
			return _supplies;
		}
		
		public function set supplyItems(obj:ArrayCollection):void {
			_supplyItems = obj;
		}
		
		public function get supplyItems():ArrayCollection {
			return _supplyItems;
		}
	}
}