package com.j_nid.controls {
	
	import com.adobe.cairngorm.control.FrontController;
	import com.j_nid.commands.*;

	public class JNidController extends FrontController	{
		
		public function JNidController() {
			initializeCommands();
		}
		
		private function initializeCommands():void {
			// ProductType commands.
			addCommand(EventNames.LIST_PRODUCT_TYPE, ListProductTypeCommand);
			addCommand(EventNames.CREATE_PRODUCT_TYPE, CreateProductTypeCommand);
			addCommand(EventNames.UPDATE_PRODUCT_TYPE, UpdateProductTypeCommand);
//			addCommand(EventNames.DELETE_PRODUCT_TYPE, DeleteProductTypeCommand);
			// Product commands.
			addCommand(EventNames.LIST_PRODUCT, ListProductCommand);
			addCommand(EventNames.CREATE_PRODUCT, CreateProductCommand);
			addCommand(EventNames.UPDATE_PRODUCT, UpdateProductCommand);
//			addCommand(EventNames.DELETE_PRODUCT, DeleteProductCommand);
			// Person commands.
			addCommand(EventNames.LIST_PERSON, ListPersonCommand);
			addCommand(EventNames.CREATE_PERSON, CreatePersonCommand);
			addCommand(EventNames.UPDATE_PERSON, UpdatePersonCommand);
			// BankAccount commands.
			addCommand(EventNames.LIST_BANK_NAME, ListBankNameCommand);
			addCommand(EventNames.LIST_BANK_ACCOUNT, ListBankAccountCommand);
			addCommand(EventNames.CREATE_BANK_ACCOUNT, CreateBankAccountCommand);
			// PhoneNumber commands.
			addCommand(EventNames.LIST_PHONE_TYPE, ListPhoneTypeCommand);
			addCommand(EventNames.LIST_PHONE_NUMBER, ListPhoneNumberCommand);
			addCommand(EventNames.CREATE_PHONE_NUMBER, CreatePhoneNumberCommand);
			// Order commands.
			addCommand(EventNames.LIST_ORDER, ListOrderCommand);
			addCommand(EventNames.CREATE_ORDER, CreateOrderCommand);
			// OrderItem commands.
			addCommand(EventNames.LIST_ORDER_ITEM, ListOrderItemCommand);
			addCommand(EventNames.CREATE_ORDER_ITEM, CreateOrderItemCommand);
			// Payment commands.
			addCommand(EventNames.LIST_PAYMENT, ListPaymentCommand);
			addCommand(EventNames.CREATE_PAYMENT, CreatePaymentCommand);
		}
	}
}