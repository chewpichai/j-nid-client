package com.j_nid.models {
	
	import com.j_nid.utils.DateUtils;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.events.CollectionEvent;
	
	[Bindable]
	public class Supply extends Model {
		
		private var _person:Person;
		private var _personID:int;
		private var _notation:String;
		private var _created:Date;
		private var _total:Number;
		private var _supplyItems:ArrayCollection;
		
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
			total = 0;
			supplyItems = new ArrayCollection();
			supplyItems.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChangeListener);
		}
		
		private function itemChangeListener(evt:CollectionEvent):void {
			total = 0;
			var cursor:IViewCursor = supplyItems.createCursor();
			while (!cursor.afterLast) {
				total += SupplyItem(cursor.current).total;
				cursor.moveNext();
			}
		}
		
		public function addItem(item:SupplyItem):void {
			item.supply = this;
			supplyItems.addItem(item);
		}
		
		public function removeItem(item:SupplyItem):void {
			item.supply = null;
			supplyItems.removeItemAt(supplyItems.getItemIndex(item));
		}
		
		public function clearItems():void {
			supplyItems.removeAll();
		}
		
		public function getItemAt(obj:int):SupplyItem {
			return SupplyItem(supplyItems.getItemAt(obj));
		}
		
		public function toXML():XML {
			var xml:XML = <supply/>
			xml.person_id = person.id;
			xml.notation = notation;
			xml.created = DateUtils.format(created);
			return xml;
		}
		
		override public function toString():String {
			return person.name + " [" + 
				DateUtils.format(created, "DD MMM YYYY") +
				"]";
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set person(obj:Person):void {
			_person = obj;
		}
		
		public function get person():Person {
			return _person;
		}
		
		public function get personID():int {
			return _personID;
		}

		public function set personID(obj:int):void {
			_personID = obj;
		}
		
		public function get notation():String {
			return _notation;
		}

		public function set notation(obj:String):void {
			_notation = obj;
		}
		
		public function get created():Date {
			return _created;
		}

		public function set created(obj:Date):void {
			_created = obj;
		}
		
		public function get total():Number {
			return _total;
		}
		
		public function set total(obj:Number):void {
			_total = obj;
		}
		
		public function set supplyItems(obj:ArrayCollection):void {
			_supplyItems = obj;
		}
		
		public function get supplyItems():ArrayCollection {
			return _supplyItems;
		}
	}
}