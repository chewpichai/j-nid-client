package com.j_nid.models {
	
	import com.j_nid.utils.Utils;
	
	[Event(name="supplyCreated", type="com.j_nid.events.JNidEvent")]
	[Event(name="supplyDeleted", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class Supply extends Model {
	    
	    private static var _supplies:Array = [];
        private static var _idMap:Object = {};
        public static var loaded:Boolean = false;
		
		public var personID:uint;
		public var notation:String;
		public var created:Date;
		// Temporary for create supply.
        private var _supplyItems:Array;
		
		public static function fromXML(obj:XML):Supply {
    		var supply:Supply = new Supply();
    		supply.id = obj.id;
    		supply.personID = obj.person_id;
    		supply.notation = obj.notation;
    		supply.created = new Date(Date.parse(obj.created));
			return supply;
    	}
    	
    	public static function all():Array {
            return _supplies;
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
            _supplies.push(obj);
            _idMap[obj.id] = obj;
        }
        
        public static function getByID(obj:int):Supply {
            return _idMap[obj];
        }
        
        public static function filterByPerson(personID:uint):Array {
            return _supplies.filter(
                        function(supply:Supply, index:int, arr:Array):Boolean {
                            return supply.personID == personID;
                        });
        }
        
        public static function deleteSupply(obj:uint):void {
            var supply:Supply = getByID(obj);
            for each (var item:SupplyItem in supply.supplyItems) {
                Supply.deleteSupply(item.id);
            }
            _supplies.splice(_supplies.indexOf(supply), 1);
            delete _idMap[supply.id];
        }
		
		public function Supply()	{
			super();
			notation = "";
			created = new Date();
		}
		
		public function toXML():XML {
			var xml:XML = <supply/>
			xml.person_id = person.id;
			xml.notation = notation;
			xml.created = Utils.formatDate(created);
			if (_supplyItems != null) {
                xml.supply_items = <supply_items/>
                for each (var item:SupplyItem in _supplyItems) {
                    xml.supply_items.appendChild(item.toXML());
                }
            }
			return xml;
		}
		
		override public function toString():String {
			return person.name + " [" + 
				   Utils.formatDate(created, "DD MMM YYYY") + "]";
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function set person(obj:Person):void {
			personID = obj.id;
		}
		
		public function get person():Person {
			return Person.getByID(personID);
		}
		
		public function set supplyItems(obj:Array):void {
			_supplyItems = obj;
		}
		
		public function get supplyItems():Array {
			if (id == 0) {
				return _supplyItems;
			}
			return SupplyItem.filterBySupply(id);
		}
		
		public function set total(obj:Number):void {
			
		}
		
		public function get total():Number {
			var sum:Number = 0;
			for each (var supplyItem:SupplyItem in supplyItems) {
				sum += supplyItem.total;
			}
			return sum;
		}
	}
}