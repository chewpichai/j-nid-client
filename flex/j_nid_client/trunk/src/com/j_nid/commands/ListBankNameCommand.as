package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.BankAccountDelegate;
	import com.j_nid.events.JNidEvent;
	import com.j_nid.models.BankAccount;
	import com.j_nid.utils.CairngormUtils;
	
	public class ListBankNameCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:BankAccountDelegate = new BankAccountDelegate(this);
			delegate.listBankName();
		}
		
		override public function result(event:Object):void {
			super.result(event);
			BankAccount.bankNames = event.result.bank;
			BankAccount.bankNameLoaded = true;
			CairngormUtils.dispatchEvent(JNidEvent.DATA_LOADED);
		}
	}
}