package com.j_nid.models {
	
	import com.j_nid.events.JNidEvent;
	import com.j_nid.utils.ModelUtils;
	import com.j_nid.utils.Utils;
	
	[Bindable]
	public class Supply extends Model {
		
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
		
		public function Supply()	{
			super();
			notation = "";
			created = new Date();
			//
            createEvent = JNidEvent.CREATE_SUPPLY;
            updateEvent = JNidEvent.UPDATE_SUPPLY;
            deleteEvent = JNidEvent.DELETE_SUPPLY;
		}
		
		public function toXML():XML {
			var xml:XML = <supply/>
			xml.person_id = person.id;
			xml.notation = notation;
			xml.created = Utils.getInstance().formatDate(created);
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
				   Utils.getInstance().formatDate(created, "DD MMM YYYY") + "]";
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function set person(obj:Person):void {
			personID = obj.id;
		}
		
		public function get person():Person {
			return ModelUtils.getInstance().getPerson(personID);
		}
		
		public function set supplyItems(obj:Array):void {
			_supplyItems = obj;
		}
		
		public function get supplyItems():Array {
			if (id == 0) {
				return _supplyItems;
			}
			return ModelUtils.getInstance().getSupplyItemsBySupply(id);
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