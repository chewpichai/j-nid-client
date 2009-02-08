package com.j_nid.models {
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Order extends Model {
		
		private var _person:Person;
		private var _notation:String;
		private var _orderItems:ArrayCollection;
		
		public function Order()	{
			super();
			notation = "";
			orderItems = new ArrayCollection();
		}
		
		public function addItem(obj:OrderItem):void {
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
			xml.person = person.id;
			xml.notation = notation;
			for each (var item:OrderItem in orderItems) {
				xml.appendChild(item.toXML());
			}
			return xml;
		}
		
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
		
		public function set orderItems(obj:ArrayCollection):void {
			_orderItems = obj;
		}
		
		public function get orderItems():ArrayCollection {
			return _orderItems;
		}
	}
}