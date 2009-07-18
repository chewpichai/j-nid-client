package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.PersonDelegate;
	import com.j_nid.models.BankAccount;
	import com.j_nid.models.Person;
	import com.j_nid.models.PhoneNumber;

	public class CreatePersonCommand extends RespondCommand {
	    
	    private var _person:Person;
	    
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			_person = event.data;
			var delegate:PersonDelegate = new PersonDelegate(this);
			delegate.createPerson(_person);
		}
		
		override public function result(event:Object):void {
			super.result(event);
			var xml:XML = event.result;
			Person.add(xml);
			for each (var account:XML in xml.bank_accounts.bank_account) {
                BankAccount.add(account);
            }
            for each (var number:XML in xml.phone_numbers.phone_number) {
                PhoneNumber.add(number);
            }
			_person.dispatchCreated();
		}
	}
}