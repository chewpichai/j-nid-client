package com.j_nid.controls {
	
	import com.adobe.cairngorm.control.FrontController;
	import com.j_nid.commands.*;
	import com.j_nid.events.JNidEvent;

	public class JNidController extends FrontController	{
		
		public function JNidController() {
			initializeCommands();
		}
		
		private function initializeCommands():void {
			// Log in and log out commands.
			addCommand(JNidEvent.LOG_IN, LogInCommand);
			addCommand(JNidEvent.LOG_OUT, LogOutCommand);
			// ProductType commands.
			addCommand(JNidEvent.LIST_PRODUCT_TYPE, ListProductTypeCommand);
			addCommand(JNidEvent.CREATE_PRODUCT_TYPE, CreateProductTypeCommand);
			addCommand(JNidEvent.UPDATE_PRODUCT_TYPE, UpdateProductTypeCommand);
//			addCommand(JNidEvent.DELETE_PRODUCT_TYPE, DeleteProductTypeCommand);
			// Product commands.
			addCommand(JNidEvent.LIST_PRODUCT, ListProductCommand);
			addCommand(JNidEvent.CREATE_PRODUCT, CreateProductCommand);
			addCommand(JNidEvent.UPDATE_PRODUCT, UpdateProductCommand);
//			addCommand(JNidEvent.DELETE_PRODUCT, DeleteProductCommand);
			// Person commands.
			addCommand(JNidEvent.LIST_PERSON, ListPersonCommand);
			addCommand(JNidEvent.CREATE_PERSON, CreatePersonCommand);
			addCommand(JNidEvent.UPDATE_PERSON, UpdatePersonCommand);
			// BankAccount commands.
			addCommand(JNidEvent.LIST_BANK_NAME, ListBankNameCommand);
			addCommand(JNidEvent.LIST_BANK_ACCOUNT, ListBankAccountCommand);
			addCommand(JNidEvent.CREATE_BANK_ACCOUNT, CreateBankAccountCommand);
			addCommand(JNidEvent.DELETE_BANK_ACCOUNT, DeleteBankAccountCommand);
			// PhoneNumber commands.
			addCommand(JNidEvent.LIST_PHONE_TYPE, ListPhoneTypeCommand);
			addCommand(JNidEvent.LIST_PHONE_NUMBER, ListPhoneNumberCommand);
			addCommand(JNidEvent.CREATE_PHONE_NUMBER, CreatePhoneNumberCommand);
			addCommand(JNidEvent.DELETE_PHONE_NUMBER, DeletePhoneNumberCommand);
			// Order commands.
			addCommand(JNidEvent.LIST_ORDER, ListOrderCommand);
			addCommand(JNidEvent.CREATE_ORDER, CreateOrderCommand);
			addCommand(JNidEvent.UPDATE_ORDER, UpdateOrderCommand);
			addCommand(JNidEvent.DELETE_ORDER, DeleteOrderCommand);
			addCommand(JNidEvent.ORDER_CREATED, OrderCreatedCommand);
			// OrderItem commands.
			addCommand(JNidEvent.LIST_ORDER_ITEM, ListOrderItemCommand);
			addCommand(JNidEvent.CREATE_ORDER_ITEM, CreateOrderItemCommand);
			addCommand(JNidEvent.DELETE_ORDER_ITEM, DeleteOrderItemCommand);
			// Payment commands.
			addCommand(JNidEvent.LIST_PAYMENT, ListPaymentCommand);
			addCommand(JNidEvent.CREATE_PAYMENT, CreatePaymentCommand);
			addCommand(JNidEvent.DELETE_PAYMENT, DeletePaymentCommand);
			// Supply commands.
			addCommand(JNidEvent.LIST_SUPPLY, ListSupplyCommand);
			addCommand(JNidEvent.CREATE_SUPPLY, CreateSupplyCommand);
			addCommand(JNidEvent.UPDATE_SUPPLY, UpdateSupplyCommand);
			addCommand(JNidEvent.DELETE_SUPPLY, DeleteSupplyCommand);
			// SupplyItem commands.
			addCommand(JNidEvent.LIST_SUPPLY_ITEM, ListSupplyItemCommand);
			addCommand(JNidEvent.CREATE_SUPPLY_ITEM, CreateSupplyItemCommand);
			addCommand(JNidEvent.DELETE_SUPPLY_ITEM, DeleteSupplyItemCommand);
		}
	}
}