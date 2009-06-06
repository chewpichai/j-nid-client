package com.j_nid.models {
    
    import com.adobe.cairngorm.model.IModelLocator;
    import com.j_nid.events.JNidEvent;
    import com.j_nid.utils.CairngormUtils;
    
    import flash.events.EventDispatcher;
    
    import mx.core.Application;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    
    [Event(name="personCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="paymentCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="orderCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="productCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="productTypeCreated", type="com.j_nid.events.JNidEvent")]
    
    [ResourceBundle("ProductPage")]
    
    [Bindable]
    public class JNidModelLocator extends EventDispatcher
                                  implements IModelLocator {
        
        private static var resourceManager:IResourceManager = 
            ResourceManager.getInstance();
        private static var modelLocator:JNidModelLocator;
        public static const ALL_TYPE:ProductType = 
            new ProductType(0, resourceManager.getString(
                                     'ProductPage', 'All'));
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
        // flag for make sure all data were loaded.
        public var isLoadComplete:Boolean = false;
        
        public function JNidModelLocator() {
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
        
        public function createproductTypesWithAll():void {
            productTypesWithAll = productTypes.slice();
            productTypesWithAll.unshift(ALL_TYPE);
        }
        
        public function setProductTypes(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var productType:ProductType = ProductType.fromXML(xml);
                productTypes.push(productType);
                _productTypeIDMap[productType.id] = productType;
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
                bankAccounts.push(bankAccount);
            }
            _loadedBankAccount = true;
            setRelateModels();
        }
        
        public function setPhoneNumbers(obj:XML):void {
            for each (var xml:XML in obj.children()) {
                var phoneNumber:PhoneNumber = PhoneNumber.fromXML(xml);
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
                // Set relate for payments.
                for each (var obj:Object in payments) {
                    var payment:Payment = Payment(obj);
                    getPerson(payment.personID).addPayment(payment);
                }
                // Set relate for order items.
                for each (obj in orderItems) {
                    var item:OrderItem = OrderItem(obj);
                    getOrder(item.orderID).addOrderItem(item);
                    item.product = getProduct(item.productID);
                }
                // Set relate for orders.
                for each (obj in orders) {
                    var order:Order = Order(obj);
                    getPerson(order.personID).addOrder(order);
                }
                // Set relate for products.
                for each (obj in products) {
                    var product:Product = Product(obj);
                    getProductType(product.productTypeID).addProduct(product);
                }
                // Set relate for bank accounts.
                for each (obj in bankAccounts) {
                    var bankAccount:BankAccount = BankAccount(obj);
                    getPerson(bankAccount.personID).addBankAccount(bankAccount);
                }
                // Set relate for bank accounts.
                for each (obj in phoneNumbers) {
                    var phoneNumber:PhoneNumber = PhoneNumber(obj);
                    getPerson(phoneNumber.personID).addPhoneNumber(phoneNumber);
                }
                for each (obj in supplyItems) {
                    var supplyItem:SupplyItem = SupplyItem(obj);
                    getSupply(supplyItem.supplyID).addSupplyItem(supplyItem);
                    supplyItem.product = getProduct(supplyItem.productID);
                }
                // Set relate for orders.
                for each (obj in supplies) {
                    var supply:Supply = Supply(obj);
                    getPerson(supply.personID).addSupply(supply);
                }
                isLoadComplete = true;
            }
        }
        
        public function createOrder(obj:XML):void {
            var order:Order = Order.fromXML(obj);
            _orderIDMap[order.id] = order;
            var person:Person = getPerson(order.personID);
            person.addOrder(order);
            for each (var item:OrderItem in orderToCreate.orderItems) {
                item.orderID = order.id;
                CairngormUtils.dispatchEvent(JNidEvent.CREATE_ORDER_ITEM, item);
            }
            orders.push(order);
        }
        
        public function createOrderItem(obj:XML):void {
            var item:OrderItem = OrderItem.fromXML(obj);
            _orderItemIDMap[item.id] = item;
            item.product = getProduct(item.productID);
            var order:Order = getOrder(item.orderID);
            order.addOrderItem(item);
            orderItems.push(item);
            if (order.orderItems.length == orderToCreate.orderItems.length) {
                // For cash customer create payment.
                if (order.personID <= 24) {
                    var payment:Payment = new Payment();
                    payment.amount = order.total;
                    payment.person = order.person;
                    CairngormUtils.dispatchEvent(JNidEvent.CREATE_PAYMENT,
                                       payment);
                }
                CairngormUtils.dispatchEvent(JNidEvent.ORDER_CREATED, order);
                var event:JNidEvent = new JNidEvent(JNidEvent.ORDER_CREATED,
                                                    order);
                dispatchEvent(event);
            }
        }
        
        public function createSupply(obj:XML):void {
            var supply:Supply = Supply.fromXML(obj);
            _supplyIDMap[supply.id] = supply;
            var person:Person = getPerson(supply.personID);
            person.addSupply(supply);
            for each (var item:SupplyItem in supplyToCreate.supplyItems) {
                item.supplyID = supply.id;
                CairngormUtils.dispatchEvent(JNidEvent.CREATE_SUPPLY_ITEM, item);
            }
            supplies.push(supply);
        }
        
        public function createSupplyItem(obj:XML):void {
            var item:SupplyItem = SupplyItem.fromXML(obj);
            _supplyItemIDMap[item.id] = item;
            item.product = getProduct(item.productID);
            getSupply(item.supplyID).addSupplyItem(item);
            supplyItems.push(item);
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
                CairngormUtils.dispatchEvent(JNidEvent.CREATE_BANK_ACCOUNT,
                    bankAccount);
            }
            for each (var phoneNumber:PhoneNumber in personToCreate.phoneNumbers) {
                phoneNumber.personID = person.id;
                CairngormUtils.dispatchEvent(JNidEvent.CREATE_PHONE_NUMBER,
                    phoneNumber);
            }
            people.push(person);
            var event:JNidEvent = new JNidEvent(JNidEvent.PERSON_CREATED,
                                                person);
            dispatchEvent(event);
        }
        
        public function createBankAccount(obj:XML):void {
            var bankAccount:BankAccount = BankAccount.fromXML(obj);
            _bankAccountIDMap[bankAccount.id] = bankAccount;
            getPerson(bankAccount.personID).addBankAccount(bankAccount);
            bankAccounts.push(bankAccount);
        }
        
        public function createPhoneNumber(obj:XML):void {
            var phoneNumber:PhoneNumber = PhoneNumber.fromXML(obj);
            _phoneNumberIDMap[phoneNumber.id] = phoneNumber;
            getPerson(phoneNumber.personID).addPhoneNumber(phoneNumber);
            phoneNumbers.push(phoneNumber);
        }
        
        public function createProductType(obj:XML):void {
            var productType:ProductType = ProductType.fromXML(obj);
            _productTypeIDMap[productType.id] = productType;
            productTypes.push(productType);
            createproductTypesWithAll();
            var event:JNidEvent = new JNidEvent(JNidEvent.PRODUCT_TYPE_CREATED,
                                                productType);
            dispatchEvent(event);
        }
        
        public function createProduct(obj:XML):void {
            var product:Product = Product.fromXML(obj);
            _productIDMap[product.id] = product;
            getProductType(product.productTypeID).addProduct(product);
            products.push(product);
            var event:JNidEvent = new JNidEvent(JNidEvent.PRODUCT_CREATED,
                                                product);
            dispatchEvent(event);
        }
        
        public function createPayment(obj:XML):void {
            var payment:Payment = Payment.fromXML(obj);
            getPerson(payment.personID).addPayment(payment);
            payments.push(payment);
            var outStandingOrders:Array = payment.person.orders.source.filter(
                function (order:*, index:int, array:Array):Boolean {
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
            var event:JNidEvent = new JNidEvent(JNidEvent.PAYMENT_CREATED,
                                                payment);
            dispatchEvent(event);
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