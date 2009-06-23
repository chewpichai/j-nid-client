package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.BankAccountDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class DeleteBankAccountCommand implements ICommand, IResponder {
		
		public function execute(event:CairngormEvent):void {
			var delegate:BankAccountDelegate = new BankAccountDelegate(this);
			delegate.deleteBankAccount(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.deleteBankAccount(event.result);
		}
		
		public function fault(event:Object):void {
			
		}
	}
}