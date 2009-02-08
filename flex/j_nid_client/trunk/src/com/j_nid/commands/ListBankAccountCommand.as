package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.BankAccountDelegate;
	import com.j_nid.models.JNidModelLocator;
	
	import mx.rpc.IResponder;

	public class ListBankAccountCommand implements ICommand, IResponder	{
		
		public function execute(event:CairngormEvent):void {
			var delegate:BankAccountDelegate = new BankAccountDelegate(this);
			delegate.listBankAccount();
		}
		
		public function result(event:Object):void {
			var model:JNidModelLocator = JNidModelLocator.getInstance();
			model.setBankAccounts(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}