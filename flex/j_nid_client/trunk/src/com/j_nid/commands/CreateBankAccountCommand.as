package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.BankAccountDelegate;
	import com.j_nid.models.BankAccount;

    public class CreateBankAccountCommand extends RespondCommand {
        
        private var _bankAccount:BankAccount;
        
        override public function execute(event:CairngormEvent):void {
            super.execute(event);
            _bankAccount = event.data;
            var delegate:BankAccountDelegate = new BankAccountDelegate(this);
            delegate.createBankAccount(_bankAccount);
        }
        
        override public function result(event:Object):void {
            super.result(event);
            BankAccount.add(event.result);
            _bankAccount.dispatchCreated();
        }
    }
}