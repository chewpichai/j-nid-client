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
		private var _people:ArrayCollection;
		private var _bankAccounts:ArrayCollection;
		private var _phoneNumbers:ArrayCollection;
		private var _productTypeIDMap:Object;
		private var _personIDMap:Object;
		
		public function JNidModelLocator() {
			
		}
		
		public static function getInstance():JNidModelLocator {
			if (modelLocator == null) {
				modelLocator = new JNidModelLocator();
			}
			return modelLocator;
		}
		
		public function setProductTypes(obj:XML):void {
			productTypes = new ArrayCollection();
			var productType:ProductType;
			_productTypeIDMap = {};
			for each (var xml:XML in obj.children()) {
				productType = ProductType.fromXML(xml);
				productTypes.addItem(productType);
				// Create hash of productType.
				_productTypeIDMap[productType.id] = productType;
			}
			CairngormUtils.dispatchEvent(EventNames.LIST_PRODUCT);
		}
		
		public function setProducts(obj:XML):void {
			var productArray:Array = new Array();
			var product:Product;
			var productType:ProductType;
			for each (var xml:XML in obj.children()) {
				product = Product.fromXML(xml);
				productArray.push(product);
				// Add product to product type.
				productType = getProductType(xml.type_id);
				productType.addProduct(product);
			}
			products = new ArrayCollection(productArray);
		}
		
		public function setPeople(obj:XML):void {
			people = new ArrayCollection();
			_personIDMap = {};
			var person:Person;
			for each (var xml:XML in obj.children()) {
				person = Person.fromXML(xml);
				people.addItem(person);
				_personIDMap[person.id] = person;
			}
			CairngormUtils.dispatchEvent(EventNames.LIST_BANK_ACCOUNT);
			CairngormUtils.dispatchEvent(EventNames.LIST_PHONE_NUMBER);
		}
		
		public function setBankAccounts(obj:XML):void {
			bankAccounts = new ArrayCollection();
			var bankAccount:BankAccount;
			var person:Person;
			for each (var xml:XML in obj.children()) {
				bankAccount = BankAccount.fromXML(xml);
				bankAccounts.addItem(bankAccount);
				// Add bank account to person.
				person = getPerson(xml.person_id);
				person.addBankAccount(bankAccount);
			}
		}
		
		public function setPhoneNumbers(obj:XML):void {
			phoneNumbers = new ArrayCollection();
			var phoneNumber:PhoneNumber;
			var person:Person;
			for each (var xml:XML in obj.children()) {
				phoneNumber = PhoneNumber.fromXML(xml);
				phoneNumbers.addItem(phoneNumber);
				// Add phone number to person.
				person = getPerson(xml.person_id);
				person.addPhoneNumber(phoneNumber);
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
		
		public function updateProduct(product:Product):void {
			for (var i:int = 0; i < products.length; i++) {
				if (product.id == products.getItemAt(i).id) {
					products.setItemAt(product, i);
					break;
				}
			}
			// For trugger data binding.
			products = new ArrayCollection(products.toArray());
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
	}
}