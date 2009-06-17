package com.j_nid.models {
	
	import com.j_nid.events.JNidEvent;
	import com.j_nid.utils.ModelUtils;
	import com.j_nid.utils.Utils;
	
	[Bindable]
	public class Payment extends Model {
		
		public var personID:uint;
		public var amount:Number;
		public var notation:String;
		public var created:Date;
		
		public static function fromXML(obj:XML):Payment {
    		var payment:Payment = new Payment();
    		payment.id = obj.id;
    		payment.personID = obj.person_id;
    		payment.amount = obj.amount;
    		payment.notation = obj.notation;
    		payment.created = new Date(Date.parse(obj.created));
			return payment;
    	}
		
		public function Payment() {
			super();
			personID = 0;
			amount = 0;
			notation = "";
			created = new Date();
			//
			createEvent = JNidEvent.CREATE_PAYMENT;
			updateEvent = JNidEvent.UPDATE_PAYMENT;
			deleteEvent = JNidEvent.DELETE_PAYMENT;
		}
		
		public function toXML():XML {
			var xml:XML = <payment/>;
			xml.person_id = personID;
			xml.amount = amount;
			xml.notation = notation;
			xml.created = Utils.getInstance().formatDate(created);
			return xml;
		}
		
/* ----- get-set function. ------------------------------------------------- */

		public function get person():Person {
			return ModelUtils.getInstance().getPerson(personID);
		}
	}
}