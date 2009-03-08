package com.j_nid.models {
	
	import com.adobe.cairngorm.model.IModelLocator;
	import com.j_nid.controls.EventNames;
	import com.j_nid.utils.CairngormUtils;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class JNidModelLocator implements IModelLocator {
		
		private static var modelLocator:JNidModelLocator;
		private var _productTypes:ArrayCollection;
		private var _products:ArrayCollection;
		private var _productIDMap:Object;
		private var _people:ArrayCollection;
		private var _bankAccounts:ArrayCollection;
		private var _phoneNumbers:ArrayCollection;
		private var _productTypeIDMap:Object;
		private var _personIDMap:Object;
		private var _personNameMap:Object;
		private var _productTypesWithAll:ArrayCollection;
		private var _orders:ArrayCollection;
		private var _orderIDMap:Object;
		private var _orderItems:ArrayCollection;
		private var _orderItemIDMap:Object;
		private var _orderToCreate:Order;
		public const ALL_TYPE:ProductType = new ProductType(0, "All");
		private var _loadedProduct:Boolean = false;
		private var _loadedOrder:Boolean = false;
		
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
				// Create hash of productType.
				_productTypeIDMap[productType.id] = productType;
			}
			productTypes = new ArrayCollection(typeArray);
			ProductTypesWithAll = new ArrayCollection(typeArray);
			CairngormUtils.dispatchEvent(EventNames.LIST_PRODUCT);
		}
		
		public function setProducts(obj:XML):void {
			var productArray:Array = new Array();
			_productIDMap = {};
			for each (var xml:XML in obj.children()) {
				var product:Product = Product.fromXML(xml);
				_productIDMap[product.id] = product;
				productArray.push(product);
				// Add product to product type.
				var productType:ProductType = getProductType(xml.type_id);
				productType.addProduct(product);
			}
			products = new ArrayCollection(productArray);
			_loadedProduct = true;
			getOrderItemList();
		}
		
		public function setPeople(obj:XML):void {
			people = new ArrayCollection();
			_personIDMap = {};
			_personNameMap = {};
			for each (var xml:XML in obj.children()) {
				var person:Person = Person.fromXML(xml);
				people.addItem(person);
				_personIDMap[person.id] = person;
				_personNameMap[person.name] = person;
			}
			CairngormUtils.dispatchEvent(EventNames.LIST_BANK_ACCOUNT);
			CairngormUtils.dispatchEvent(EventNames.LIST_PHONE_NUMBER);
			CairngormUtils.dispatchEvent(EventNames.LIST_ORDER);
		}
		
		public function setBankAccounts(obj:XML):void {
			var bankAccountArray:Array = new Array();
			for each (var xml:XML in obj.children()) {
				var bankAccount:BankAccount = BankAccount.fromXML(xml);
				bankAccountArray.push(bankAccount);
				// Add bank account to person.
				var person:Person = getPerson(xml.person_id);
				person.addBankAccount(bankAccount);
			}
			bankAccounts = new ArrayCollection(bankAccountArray);
		}
		
		public function setPhoneNumbers(obj:XML):void {
			var phoneNumberArray:Array = new Array();
			for each (var xml:XML in obj.children()) {
				var phoneNumber:PhoneNumber = PhoneNumber.fromXML(xml);
				phoneNumberArray.push(phoneNumber);
				// Add phone number to person.
				var person:Person = getPerson(xml.person_id);
				person.addPhoneNumber(phoneNumber);
			}
			phoneNumbers = new ArrayCollection(phoneNumberArray);
		}
		
		public function setOrders(obj:XML):void {
			var orderArray:Array = new Array();
			_orderIDMap = {};
			for each (var xml:XML in obj.children()) {
				var order:Order = Order.fromXML(xml);
				orderArray.push(order);
				_orderIDMap[order.id] = order;
				var person:Person = getPerson(xml.person_id);
				person.addOrder(order);
			}
			orders = new ArrayCollection(orderArray);
			_loadedOrder = true;
			getOrderItemList();
		}
		
		public function setOrderItems(obj:XML):void {
			var itemArray:Array = new Array();
			_orderItemIDMap = {};
			for each (var xml:XML in obj.children()) {
				var item:OrderItem = OrderItem.fromXML(xml);
				_orderItemIDMap[item.id] = item;
				var order:Order = getOrder(xml.order_id);
				order.addItem(item);
				item.product = getProduct(xml.product_id);
			}
			orderItems = new ArrayCollection(itemArray);
		}
		
		public function createOrder(obj:XML):void {
			var order:Order = Order.fromXML(obj);
			_orderIDMap[order.id] = order;
			var person:Person = getPerson(obj.person_id);
			person.addOrder(order);
			for each (var item:OrderItem in _orderToCreate.orderItems) {
				item.order = order;
				CairngormUtils.dispatchEvent(EventNames.CREATE_ORDER_ITEM, item);
			}
			var orderArray:Array = orders.toArray();
			orderArray.push(order);
			orders = new ArrayCollection(orderArray);
		}
		
		public function createOrderItem(obj:XML):void {
			var item:OrderItem = OrderItem.fromXML(obj);
			_orderItemIDMap[item.id] = item;
			var order:Order = getOrder(obj.order_id);
			order.addItem(item);
			var itemArray:Array = orderItems.toArray();
			itemArray.push(item);
			orderItems = new ArrayCollection(itemArray);
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
			products = new ArrayCollection(products.toArray());
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
		
		private function getProduct(id:int):Product {
			if (_productIDMap == null) {
				return null;
			}
			return _productIDMap[id];
		}
		
		private function getOrderItemList():void {
			if (_loadedOrder && _loadedProduct) {
				CairngormUtils.dispatchEvent(EventNames.LIST_ORDER_ITEM);
			}
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
		
		public function set ProductTypesWithAll(obj:ArrayCollection):void {
			// Copy original array.
			_productTypesWithAll = new ArrayCollection(obj.toArray().slice(0));
			_productTypesWithAll.addItemAt(ALL_TYPE, 0);
		}
		
		public function get ProductTypesWithAll():ArrayCollection {
			return _productTypesWithAll;
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
	}
}