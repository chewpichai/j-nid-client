package com.j_nid.models {
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Order extends Model {
		
		private var _person:Person;
		private var _notation:String;
		private var _status:int;
		private var _created:Date;
		private var _orderItems:ArrayCollection;
		
		public static function fromXML(obj:XML):Order {
    		var order:Order = new Order();
    		order.id = obj.id;
    		order.notation = obj.notation;
    		order.status = obj.status;
    		order.created = new Date(Date.parse(obj.created));
			return order;
    	}
		
		public function Order()	{
			super();
			notation = "";
			status = 0;
			created = new Date();
			orderItems = new ArrayCollection();
		}
		
		public function addItem(obj:OrderItem):void {
			obj.order = this;
			orderItems.addItem(obj);
		}
		
		public function removeItem(obj:OrderItem):void {
			orderItems.removeItemAt(orderItems.getItemIndex(obj));
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
			xml.status = status;
			xml.created = created;
			return xml;
		}
		
		public function toString():String {
			return created.toLocaleDateString();
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set person(obj:Person):void {
			_person = obj;
		}
		
		public function get person():Person {
			return _person;
		}
		
		public function get notation():String {
			return _notation;
		}

		public function set notation(obj:String):void {
			_notation = obj;
		}
		
		public function get status():int {
			return _status;
		}

		public function set status(obj:int):void {
			_status = obj;
		}
		
		public function get created():Date {
			return _created;
		}

		public function set created(obj:Date):void {
			_created = obj;
		}
		
		public function set orderItems(obj:ArrayCollection):void {
			_orderItems = obj;
		}
		
		public function get orderItems():ArrayCollection {
			return _orderItems;
		}
	}
}