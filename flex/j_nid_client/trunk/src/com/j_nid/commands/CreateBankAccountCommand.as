package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.BankAccountDelegate;
	import com.j_nid.utils.ModelUtils;
	import mx.rpc.IResponder;

	public class CreateBankAccountCommand implements ICommand, IResponder	{
		
		public function CreateBankAccountCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:BankAccountDelegate = new BankAccountDelegate(this);
			delegate.createBankAccount(event.data);
		}
		
		public function result(event:Object):void {
			var model:ModelUtils = ModelUtils.getInstance();
			model.createBankAccount(event.result);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}