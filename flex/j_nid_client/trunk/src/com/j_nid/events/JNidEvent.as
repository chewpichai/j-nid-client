package com.j_nid.events
{
	import flash.events.Event;

	public class JNidEvent extends Event {
		
		// Log in and out events.
        public static const LOG_IN:String = "logIn";
        public static const LOG_OUT:String = "logOut";
        // ProductType events.
        public static const LIST_PRODUCT_TYPE:String = "listProductType";
        public static const CREATE_PRODUCT_TYPE:String = "createProductType";
        public static const UPDATE_PRODUCT_TYPE:String = "updateProductType";
        public static const DELETE_PRODUCT_TYPE:String = "deleteProductType";
        public static const PRODUCT_TYPE_CREATED:String = "productTypeCreated";
        // Product events.
        public static const LIST_PRODUCT:String = "listProduct";
        public static const CREATE_PRODUCT:String = "createProduct";
        public static const UPDATE_PRODUCT:String = "updateProduct";
        public static const DELETE_PRODUCT:String = "deleteProduct";
        public static const PRODUCT_CREATED:String = "productCreated";
        // Person events.
        public static const LIST_PERSON:String = "listPerson";
        public static const CREATE_PERSON:String = "createPerson";
        public static const CREATED_PERSON:String = "createdPerson";
        public static const UPDATE_PERSON:String = "updatePerson";
        public static const DELETE_PERSON:String = "deletePerson";
        public static const PERSON_CREATED:String = "personCreated";
        public static const PERSON_UPDATED:String = "personUpdated";
        // BankAccount events.
        public static const LIST_BANK_NAME:String = "listBankName";
        public static const LIST_BANK_ACCOUNT:String = "listBankAccount";
        public static const CREATE_BANK_ACCOUNT:String = "createBankAccount";
        public static const UPDATE_BANK_ACCOUNT:String = "updateBankAccount";
        public static const DELETE_BANK_ACCOUNT:String = "deleteBankAccount";
        // PhoneNumber events.
        public static const LIST_PHONE_TYPE:String = "listPhoneType";
        public static const LIST_PHONE_NUMBER:String = "listPhoneNumber";
        public static const CREATE_PHONE_NUMBER:String = "createPhoneNumber";
        public static const UPDATE_PHONE_NUMBER:String = "updatePhoneNumber";
        public static const DELETE_PHONE_NUMBER:String = "deletePhoneNumber";
        // Order events.
        public static const LIST_ORDER:String = "listOrder";
        public static const CREATE_ORDER:String = "createOrder";
        public static const UPDATE_ORDER:String = "updateOrder";
        public static const DELETE_ORDER:String = "deleteOrder";
        public static const ORDER_CREATED:String = "orderCreated";
        public static const ORDER_DELETED:String = "orderDeleted";
        // OrderItem events.
        public static const LIST_ORDER_ITEM:String = "listOrderItem";
        public static const CREATE_ORDER_ITEM:String = "createOrderItem";
        public static const UPDATE_ORDER_ITEM:String = "updateOrderItem";
        public static const DELETE_ORDER_ITEM:String = "deleteOrderItem";
        public static const ORDER_ITEM_DELETED:String = "orderItemDeleted";
        // Payment events.
        public static const LIST_PAYMENT:String = "listPayment";
        public static const CREATE_PAYMENT:String = "createPayment";
        public static const UPDATE_PAYMENT:String = "updatePayment";
        public static const DELETE_PAYMENT:String = "deletePayment";
        public static const PAYMENT_CREATED:String = "paymentCreated";
        public static const PAYMENT_DELETED:String = "paymentDeleted";
        // Supply events.
        public static const LIST_SUPPLY:String = "listSupply";
        public static const CREATE_SUPPLY:String = "createSupply";
        public static const UPDATE_SUPPLY:String = "updateSupply";
        public static const DELETE_SUPPLY:String = "deleteSupply";
        public static const SUPPLY_DELETED:String = "supplyDeleted";
        // SupplyItem events.
        public static const LIST_SUPPLY_ITEM:String = "listSupplyItem";
        public static const CREATE_SUPPLY_ITEM:String = "createSupplyItem";
        public static const UPDATE_SUPPLY_ITEM:String = "updateSupplyItem";
        public static const DELETE_SUPPLY_ITEM:String = "deleteSupplyItem";
        public static const SUPPLY_ITEM_DELETED:String = "supplyItemDeleted";
		
		public var data:Object;
		
		public function JNidEvent(type:String,
		                          data:Object,
		                          bubbles:Boolean=false,
		                          cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		override public function clone():Event {
			return new JNidEvent(type, data, bubbles, cancelable);
		}
	}
}