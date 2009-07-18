package com.j_nid.models {
	
	import com.j_nid.events.JNidEvent;
	import com.j_nid.utils.Utils;
	
	[Event(name="paymentCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="paymentDeleted", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class Payment extends Model {
	    
	    private static var _payments:Array = [];
        private static var _idMap:Object = {};
        public static var loaded:Boolean = false;
		
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
    	
    	public static function all():Array {
            return _payments;
        }
        
        public static function add(obj:Object):void {
            if (obj is XML) {
                obj = fromXML(XML(obj));
            } else if (obj is XMLList) {
                for each (var xml:XML in obj) {
                    add(xml);
                }
                return;
            }
            _payments.push(obj);
            _idMap[obj.id] = obj;
        }
        
        public static function getByID(obj:int):Payment {
            return _idMap[obj];
        }
        
        public static function filterByPerson(personID:uint):Array {
            return _payments.filter(
                        function(payment:Payment, index:int, arr:Array):Boolean {
                            return payment.personID == personID;
                        });
        }
        
        public static function deletePayment(obj:uint):void {
            var payment:Payment = getByID(obj);
            _payments.splice(_payments.indexOf(payment), 1);
            delete _idMap[payment.id];
        }
		
		public function Payment() {
			super();
			personID = 0;
			amount = 0;
			notation = "";
			created = new Date();
		}
		
		public function toXML():XML {
			var xml:XML = <payment/>;
			xml.person_id = personID;
			xml.amount = amount;
			xml.notation = notation;
			xml.created = Utils.formatDate(created);
			return xml;
		}
		
/* ----- get-set function. ------------------------------------------------- */

		public function get person():Person {
			return Person.getByID(personID);
		}
	}
}