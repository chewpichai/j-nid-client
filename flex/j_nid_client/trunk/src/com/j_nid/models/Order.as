package com.j_nid.models {

    import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.events.CollectionEvent;
	
	[Bindable]
	public class Order extends Model {
		
		private var _person:Person;
		private var _personID:int;
		public var notation:String;
		public var paidTotal:Number;
		public var created:Date;
		public var total:Number;
		public var orderItems:ArrayCollection;
		
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
			orderItems.addEventListener(
                CollectionEvent.COLLECTION_CHANGE, itemChangeListener);
		}
		
		private function itemChangeListener(evt:CollectionEvent):void {
			total = 0;
			var cursor:IViewCursor = orderItems.createCursor();
			while (!cursor.afterLast) {
				total += OrderItem(cursor.current).total;
				cursor.moveNext();
			}
		}
		
		public function addOrderItem(item:OrderItem):void {
			item.order = this;
			orderItems.addItem(item);
		}
		
		public function removeOrderItem(item:OrderItem):void {
			item.order = null;
			orderItems.removeItemAt(orderItems.getItemIndex(item));
		}
		
		public function clearOrderItems():void {
			orderItems.removeAll();
		}
		
		public function getOrderItemAt(obj:int):OrderItem {
			return OrderItem(orderItems.getItemAt(obj));
		}
		
		public function toXML():XML {
			var xml:XML = <order/>
			xml.person_id = person.id;
			xml.notation = notation;
			xml.paid_total = paidTotal;
			xml.created = utils.formatDate(created);
			return xml;
		}
		
		override public function toString():String {
			return person.name + " [" + 
				   utils.formatDate(created, "DD MMM YYYY") + "]";
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
		
		public function set isPaid(obj:Boolean):void {
            
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