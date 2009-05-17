package com.j_nid.models {
	
	import com.j_nid.utils.DateUtils;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.events.CollectionEvent;
	
	[Bindable]
	public class Order extends Model {
		
		private var _person:Person;
		private var _personID:int;
		private var _notation:String;
		private var _paidTotal:Number;
		private var _created:Date;
		private var _total:Number;
		private var _orderItems:ArrayCollection;
		
		public static function fromXML(obj:XML):Order {
    		var order:Order = new Order();
    		order.id = obj.id;
    		order.personID = obj.person_id;
    		order.notation = obj.notation;
    		order.paidTotal = obj.paid_total;
    		order.created = new Date(Date.parse(obj.created));
			return order;
    	}
		
		public function Order()	{
			super();
			notation = "";
			total = 0;
			paidTotal = 0;
			created = new Date();
			orderItems = new ArrayCollection();
			orderItems.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChangeListener);
		}
		
		private function itemChangeListener(evt:CollectionEvent):void {
			total = 0;
			var cursor:IViewCursor = orderItems.createCursor();
			while (!cursor.afterLast) {
				total += OrderItem(cursor.current).total;
				cursor.moveNext();
			}
		}
		
		public function addItem(item:OrderItem):void {
			item.order = this;
			orderItems.addItem(item);
		}
		
		public function removeItem(item:OrderItem):void {
			item.order = null;
			orderItems.removeItemAt(orderItems.getItemIndex(item));
		}
		
		public function clearItems():void {
			orderItems.removeAll();
		}
		
		public function getItemAt(obj:int):OrderItem {
			return OrderItem(orderItems.getItemAt(obj));
		}
		
		public function toXML():XML {
			var xml:XML = <order/>
			xml.person_id = person.id;
			xml.notation = notation;
			xml.paid_total = paidTotal;
			xml.created = DateUtils.format(created);
			return xml;
		}
		
		public function toString():String {
			return person.name + " [" + 
				DateUtils.format(created, "DD MMM YYYY") +
				"]";
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function set person(obj:Person):void {
			if (obj != null) {
				personID = obj.id;
			} else {
				personID = 0;
			}
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
		
		public function get paidTotal():Number {
			return _paidTotal;
		}
		
		public function set paidTotal(obj:Number):void {
			_paidTotal = obj;
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
		
		public function set orderItems(obj:ArrayCollection):void {
			_orderItems = obj;
		}
		
		public function get orderItems():ArrayCollection {
			return _orderItems;
		}
		
		public function get isPaid():Boolean {
			return total <= paidTotal;
		}
		
		public function get isOutstanding():Boolean {
			return total > paidTotal;
		}
		
		public function get totalToPaid():Number {
			return total - paidTotal;
		}
	}
}