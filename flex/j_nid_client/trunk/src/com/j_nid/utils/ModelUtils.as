package com.j_nid.utils {
    
    import com.j_nid.controls.ApplicationManager;
    import com.j_nid.events.JNidEvent;
    import com.j_nid.models.BankAccount;
    import com.j_nid.models.Order;
    import com.j_nid.models.OrderItem;
    import com.j_nid.models.Payment;
    import com.j_nid.models.Person;
    import com.j_nid.models.PhoneNumber;
    import com.j_nid.models.Product;
    import com.j_nid.models.ProductType;
    import com.j_nid.models.Supply;
    import com.j_nid.models.SupplyItem;
    
    import flash.events.EventDispatcher;
    
    [Event(name="personCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="paymentCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="paymentDeleted", type="com.j_nid.events.JNidEvent")]
    [Event(name="orderCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="orderDeleted", type="com.j_nid.events.JNidEvent")]
    [Event(name="orderItemDeleted", type="com.j_nid.events.JNidEvent")]
    [Event(name="supplyDeleted", type="com.j_nid.events.JNidEvent")]
    [Event(name="supplyItemDeleted", type="com.j_nid.events.JNidEvent")]
    [Event(name="productCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="productTypeCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="phoneNumberCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="phoneNumberDeleted", type="com.j_nid.events.JNidEvent")]
    [Event(name="bankAccountCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="bankAccountDeleted", type="com.j_nid.events.JNidEvent")]
    
    [Bindable]
    public class ModelUtils extends EventDispatcher {
        
        private static var instance:ModelUtils;
        
        private var _bankNames:XMLList;
        private var _phoneTypes:XMLList;
        // Array Collection for models.
        public var productTypesWithAll:Array;
        public var productTypes:Array;
        public var products:Array;
        public var people:Array;
        public var bankAccounts:Array;
        public var phoneNumbers:Array;
        public var orders:Array;
        public var orderItems:Array;
        public var supplies:Array;
        public var supplyItems:Array;
        public var payments:Array;
        // Map for get object by key.
        private var _productIDMap:Object;
        private var _productNameMap:Object;
        private var _productTypeIDMap:Object;
        private var _productTypeNameMap:Object;
        private var _personIDMap:Object;
        private var _personNameMap:Object;
        private var _paymentIDMap:Object;
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
        // flag for make sure all data were loaded.
        public var isLoadComplete:Boolean = false;
        
        public function ModelUtils() {
            productTypesWithAll = new Array();
            productTypes = new Array();
            products = new Array();
            people = new Array();
            bankAccounts = new Array();
            phoneNumbers = new Array();
            orders = new Array();
            orderItems = new Array();
            supplies = new Array();
            supplyItems = new Array();
            payments = new Array();
            _productIDMap = new Object();
            _productNameMap = new Object();
            _productTypeIDMap = new Object();
            _productTypeNameMap = new Object();
            _personIDMap = new Object();
            _personNameMap = new Object();
            _paymentIDMap = new Object();
            _orderIDMap = new Object();
            _orderItemIDMap = new Object();
            _bankAccountIDMap = new Object();
            _phoneNumberIDMap = new Object();
            _supplyIDMap = new Object();
            _supplyItemIDMap = new Object();
        }
        
        public static function getInstance():ModelUtils {
            if (instance == null) {
                instance = new ModelUtils();
            }
            return instance;
        }
        
        public function createproductTypesWithAll():void {
            productTypesWithAll = productTypes.slice();
            productTypesWithAll.unshift(ProductType.ALL);
        }
        
        public function setProductTypes(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var productType:ProductType = ProductType.fromXML(xml);
                productTypes.push(productType);
                _productTypeIDMap[productType.id] = productType;
                _productTypeNameMap[productType.name] = productType;
            }
            createproductTypesWithAll();
            _loadedProductType = true;
            setRelateModels();
        }
        
        public function setProducts(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var product:Product = Product.fromXML(xml);
                products.push(product);
                _productIDMap[product.id] = product;
                _productNameMap[product.name] = product;
            }
            _loadedProduct = true;
            setRelateModels();
        }
        
        public function setPeople(obj:XML):void {
            _personIDMap = {};
            _personNameMap = {};
            for each (var xml:XML in obj.children()) {
                var person:Person = Person.fromXML(xml);
                people.push(person);
                _personIDMap[person.id] = person;
                _personNameMap[person.name] = person;
            }
            _loadedPerson = true;
            setRelateModels();
        }
        
        public function setBankAccounts(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var bankAccount:BankAccount = BankAccount.fromXML(xml);
                _bankAccountIDMap[bankAccount.id] = bankAccount;
                bankAccounts.push(bankAccount);
            }
            _loadedBankAccount = true;
            setRelateModels();
        }
        
        public function setPhoneNumbers(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var phoneNumber:PhoneNumber = PhoneNumber.fromXML(xml);
                _phoneNumberIDMap[phoneNumber.id] = phoneNumber;
                phoneNumbers.push(phoneNumber);
            }
            _loadedPhoneNumber = true;
            setRelateModels();
        }
        
        public function setOrders(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var order:Order = Order.fromXML(xml);
                orders.push(order);
                _orderIDMap[order.id] = order;
            }
            _loadedOrder = true;
            setRelateModels();
        }
        
        public function setOrderItems(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var item:OrderItem = OrderItem.fromXML(xml);
                orderItems.push(item);
                _orderItemIDMap[item.id] = item;
            }
            _loadedOrderItem = true;
            setRelateModels();
        }
        
        public function setPayments(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var payment:Payment = Payment.fromXML(xml);
                payments.push(payment);
                _paymentIDMap[payment.id] = payment;
            }
            _loadedPayment = true;
            setRelateModels();
        }
        
        public function setSupplies(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var supply:Supply = Supply.fromXML(xml);
                supplies.push(supply);
                _supplyIDMap[supply.id] = supply;
            }
            _loadedSupply = true;
            setRelateModels();
        }
        
        public function setSupplyItems(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var item:SupplyItem = SupplyItem.fromXML(xml);
                supplyItems.push(item);
                _supplyItemIDMap[item.id] = item;
            }
            _loadedSupplyItem = true;
            setRelateModels();
        }
        
        private function setRelateModels():void {
            if (_loadedBankAccount && _loadedOrder && _loadedOrderItem &&
                _loadedPerson && _loadedPhoneNumber && _loadedProduct &&
                _loadedProductType && _loadedPayment && _loadedSupply &&
                _loadedSupplyItem) {
                
                // Use for change application state to main.
                isLoadComplete = true;
            }
        }
        
        public function createOrder(obj:XML):void {
            var order:Order = Order.fromXML(obj);
            _orderIDMap[order.id] = order;
            for each (var item:XML in obj.order_items.order_item) {
                createOrderItem(item);
            }
            orders.push(order);
            // For cash customer create payment.
            if (order.personID <= 24) {
                var payment:Payment = new Payment();
                payment.amount = order.total;
                payment.personID = order.personID;
                CairngormUtils.dispatchEvent(JNidEvent.CREATE_PAYMENT,
                    payment);
            }
            CairngormUtils.dispatchEvent(JNidEvent.ORDER_CREATED, order);
            internalDispatch(JNidEvent.ORDER_CREATED, order);
        }
        
        public function createOrderItem(obj:XML):void {
            var item:OrderItem = OrderItem.fromXML(obj);
            _orderItemIDMap[item.id] = item;
            orderItems.push(item);
        }
        
        public function createSupply(obj:XML):void {
            var supply:Supply = Supply.fromXML(obj);
            _supplyIDMap[supply.id] = supply;
            for each (var item:XML in obj.supply_items.supply_item) {
                createSupplyItem(item);
            }
            supplies.push(supply);
            ApplicationManager.getInstance().setState("mainPage");
        }
        
        public function createSupplyItem(obj:XML):void {
            var item:SupplyItem = SupplyItem.fromXML(obj);
            _supplyItemIDMap[item.id] = item;
            supplyItems.push(item);
        }
        
        public function createPerson(obj:XML):void {
            var person:Person = Person.fromXML(obj);
            _personIDMap[person.id] = person;
            _personNameMap[person.name] = person;
            for each (var account:XML in obj.bank_accounts.bank_account) {
                createBankAccount(account);
            }
            for each (var number:XML in obj.phone_numbers.phone_number) {
                createPhoneNumber(number);
            }
            people.push(person);
            internalDispatch(JNidEvent.PERSON_CREATED, person);
        }
        
        public function createBankAccount(obj:XML):void {
            var bankAccount:BankAccount = BankAccount.fromXML(obj);
            _bankAccountIDMap[bankAccount.id] = bankAccount;
            bankAccounts.push(bankAccount);
            internalDispatch(JNidEvent.BANK_ACCOUNT_CREATED, bankAccount);
        }
        
        public function createPhoneNumber(obj:XML):void {
            var phoneNumber:PhoneNumber = PhoneNumber.fromXML(obj);
            _phoneNumberIDMap[phoneNumber.id] = phoneNumber;
            phoneNumbers.push(phoneNumber);
            internalDispatch(JNidEvent.PHONE_NUMBER_CREATED, phoneNumber);
        }
        
        public function createProductType(obj:XML):void {
            var productType:ProductType = ProductType.fromXML(obj);
            _productTypeIDMap[productType.id] = productType;
            _productTypeNameMap[productType.name] = productType;
            productTypes.push(productType);
            createproductTypesWithAll();
            internalDispatch(JNidEvent.PRODUCT_TYPE_CREATED, productType);
        }
        
        public function createProduct(obj:XML):void {
            var product:Product = Product.fromXML(obj);
            _productIDMap[product.id] = product;
            _productNameMap[product.name] = product; 
            products.push(product);
            internalDispatch(JNidEvent.PRODUCT_CREATED, product);
        }
        
        public function createPayment(obj:XML):void {
            var payment:Payment = Payment.fromXML(obj);
            payments.push(payment);
            _paymentIDMap[payment.id] = payment;
            var outStandingOrders:Array = payment.person.orders.filter(
                function (order:Order, index:int, array:Array):Boolean {
                    return order.isOutstanding;
                }
            );
            var amount:Number = payment.amount;
            for each (var order:Order in outStandingOrders) {
                var totalToPaid:Number = order.totalToPaid;
                if (totalToPaid > amount) {
                    order.paidTotal += amount;
                } else {
                    order.paidTotal += totalToPaid;
                }
                amount -= totalToPaid;
                CairngormUtils.dispatchEvent(JNidEvent.UPDATE_ORDER, order);
                if (amount <= 0) {
                    break;
                }
            }
            internalDispatch(JNidEvent.PAYMENT_CREATED, payment);
        }
        
        public function getProductType(id:uint):ProductType {
            return _productTypeIDMap[id];
        }
        
        public function getProductTypeByName(name:String):ProductType {
            return _productTypeNameMap[name];
        }
        
        public function getPerson(id:uint):Person {
            return _personIDMap[id];
        }
        
        public function getSupply(id:uint):Supply {
            return _supplyIDMap[id];
        }
        
        public function getProductsByProductType(productTypeID:uint):Array {
            return products.filter(
                        function(product:Product, index:int, arr:Array):Boolean {
                            return product.productTypeID == productTypeID;
                        });
        }
        
        public function getPaymentsByPerson(personID:uint):Array {
            return payments.filter(
                        function(payment:Payment, index:int, arr:Array):Boolean {
                            return payment.personID == personID;
                        });
        }
        
        public function getOrdersByPerson(personID:uint):Array {
            return orders.filter(
                        function(order:Order, index:int, arr:Array):Boolean {
                            return order.personID == personID;
                        });
        }
        
        public function getSuppliesByPerson(personID:uint):Array {
            return supplies.filter(
                        function(supply:Supply, index:int, arr:Array):Boolean {
                            return supply.personID == personID;
                        });
        }
        
        public function getBankAccountsByPerson(personID:uint):Array {
            return bankAccounts.filter(
                        function(bankAccount:BankAccount, index:int, arr:Array):Boolean {
                            return bankAccount.personID == personID;
                        });
        }
        
        public function getPhoneNumbersByPerson(personID:uint):Array {
            return phoneNumbers.filter(
                        function(phoneNumber:PhoneNumber, index:int, arr:Array):Boolean {
                            return phoneNumber.personID == personID;
                        });
        }
        
        public function getOrderItemsByOrder(orderID:uint):Array {
            return orderItems.filter(
                        function(orderItem:OrderItem, index:int, arr:Array):Boolean {
                            return orderItem.orderID == orderID;
                        });
        }
        
        public function getSupplyItemsBySupply(supplyID:uint):Array {
            return supplyItems.filter(
                        function(supplyItem:SupplyItem, index:int, arr:Array):Boolean {
                            return supplyItem.supplyID == supplyID;
                        });
        }
        
        public function updateProduct(obj:XML):void {
            
        }
        
        public function updateProductType(obj:XML):void {
            
        }
        
        public function updatePerson(obj:XML):void {
        	internalDispatch(JNidEvent.PERSON_UPDATED, getPerson(obj.id));
        }
        
        public function updateOrder(obj:XML):void {
            
        }
        
        public function updateSupply(obj:XML):void {
            
        }
        
        public function deleteOrder(obj:XML):void {
            var order:Order = _orderIDMap[obj];
            for each (var item:OrderItem in order.orderItems) {
                orderItems.splice(orderItems.indexOf(item), 1);
                delete _orderItemIDMap[item.id];
            }
            orders.splice(orders.indexOf(order), 1);
            delete _orderIDMap[order.id];
            internalDispatch(JNidEvent.ORDER_DELETED, order);
        }
        
        public function deletePayment(obj:XML):void {
            var payment:Payment = _paymentIDMap[obj];
            payments.splice(payments.indexOf(payment), 1);
            delete _paymentIDMap[payment.id];
            internalDispatch(JNidEvent.PAYMENT_DELETED, payment);
        }
        
        // obj is <id/>
        public function deleteOrderItem(obj:XML):void {
            var orderItem:OrderItem = _orderItemIDMap[obj];
            orderItems.splice(orderItems.indexOf(orderItem), 1);
            delete _orderItemIDMap[orderItem.id];
            internalDispatch(JNidEvent.ORDER_ITEM_DELETED, orderItem);
        }
        
        public function deleteBankAccount(obj:XML):void {
        	var bankAccount:BankAccount = _bankAccountIDMap[obj];
        	bankAccounts.splice(bankAccounts.indexOf(bankAccount), 1);
        	delete _bankAccountIDMap[bankAccount.id];
        	internalDispatch(JNidEvent.BANK_ACCOUNT_DELETED, bankAccount);
        }
        
        public function deletePhoneNumber(obj:XML):void {
            var phoneNumber:PhoneNumber = _phoneNumberIDMap[obj];
            phoneNumbers.splice(phoneNumbers.indexOf(phoneNumber), 1);
            delete _phoneNumberIDMap[phoneNumber.id];
            internalDispatch(JNidEvent.PHONE_NUMBER_DELETED, phoneNumber);
        }
        
        public function deleteSupply(obj:XML):void {
            var supply:Supply = _supplyIDMap[obj];
            for each (var item:SupplyItem in supply.supplyItems) {
                supplyItems.splice(supplyItems.indexOf(item), 1);
                delete _supplyItemIDMap[item.id];
            }
            supplies.splice(supplies.indexOf(supply), 1);
            delete _supplyIDMap[supply.id];
            internalDispatch(JNidEvent.SUPPLY_DELETED, supply);
        }
        
        public function deleteSupplyItem(obj:XML):void {
            var supplyItem:SupplyItem = _supplyItemIDMap[obj];
            supplyItems.splice(supplyItems.indexOf(supplyItem), 1);
            delete _supplyItemIDMap[supplyItem.id];
            internalDispatch(JNidEvent.SUPPLY_ITEM_DELETED, supplyItem);
        }
        
        public function getPersonByName(name:String):Person {
            return _personNameMap[name];
        }
        
        public function getOrder(id:uint):Order {
            return _orderIDMap[id];
        }
        
        public function getOrderItem(id:uint):OrderItem {
            return _orderItemIDMap[id];
        }
        
        public function getProduct(id:uint):Product {
            return _productIDMap[id];
        }
        
        public function getProductByName(name:String):Product {
            return _productNameMap[name];
        }
        
        private function internalDispatch(eventName:String, data:Object):void {
        	var event:JNidEvent = new JNidEvent(eventName, data);
            dispatchEvent(event);
        }
        
/* ----- get-set function. ------------------------------------------------- */

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
    }
}