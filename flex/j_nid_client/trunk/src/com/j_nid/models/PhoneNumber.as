package com.j_nid.models {
    
	[Event(name="phoneNumberCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="phoneNumberDeleted", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class PhoneNumber extends Model {
	    
	    private static var _phoneNumbers:Array = [];
	    private static var _idMap:Object = {};
	    public static var phoneTypes:XMLList;
	    public static var loaded:Boolean = false;
	    public static var phoneTypeLoaded:Boolean = false;
		
		public var personID:uint;
		public var number:String;
		public var type:String;
		
		public static function fromXML(obj:XML):PhoneNumber {
			var phoneNumber:PhoneNumber = new PhoneNumber();
			phoneNumber.id = obj.id;
			phoneNumber.personID = obj.person_id;
			phoneNumber.number = obj.number;
			phoneNumber.type = obj.type;
			return phoneNumber;
		}
		
		public static function all():Array {
		    return _phoneNumbers;
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
            _phoneNumbers.push(obj);
            _idMap[obj.id] = obj;
        }
        
        public static function getByID(obj:int):PhoneNumber {
            return _idMap[obj];
        }
        
        public static function filterByPerson(personID:uint):Array {
            return _phoneNumbers.filter(
                        function(pn:PhoneNumber, index:int, arr:Array):Boolean {
                            return pn.personID == personID;
                        });
        }
        
        public static function deletePhoneNumber(obj:uint):void {
            var phoneNumber:PhoneNumber = getByID(obj);
            _phoneNumbers.splice(_phoneNumbers.indexOf(phoneNumber), 1);
            delete _idMap[phoneNumber.id];
        }
		
		public function PhoneNumber() {
			super();
			personID = 0;
			number = "";
			type = "";
		}
		
		public function toXML():XML {
			var xml:XML = <phone_number/>
			xml.number = number;
			xml.type = type;
			xml.person_id = personID;
			return xml;
		}
		
		override public function toString():String {
			return number;
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function set person(obj:Person):void {
			personID = obj.id;
		}
		
		public function get person():Person {
			return Person.getByID(personID);
		}
	}
}