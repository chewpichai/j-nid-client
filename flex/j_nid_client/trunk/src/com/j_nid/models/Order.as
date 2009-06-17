package com.j_nid.models {

    import com.j_nid.events.JNidEvent;
    import com.j_nid.utils.ModelUtils;
    import com.j_nid.utils.Utils;
	
	[Bindable]
	public class Order extends Model {
		
		public var personID:uint;
		public var notation:String;
		public var paidTotal:Number;
		public var created:Date;
		// Temporary for create order.
		private var _orderItems:Array;
		
		public static function fromXML(obj:XML):Order {
    		var order:Order = new Order();
    		order.id = obj.id;
    		order.personID = obj.person_id;
    		order.notation = obj.notation;
    		order.paidTotal = obj.paid_total;
    		order.created = new Date(Date.parse(obj.created));
			return order;
    	}
		
		public function Order()  {
			super();
			notation = "";
			personID = 0;
			paidTotal = 0;
			created = new Date();
			//
			createEvent = JNidEvent.CREATE_ORDER;
			updateEvent = JNidEvent.UPDATE_ORDER;
			deleteEvent = JNidEvent.DELETE_ORDER;
		}
		
		public function toXML():XML {
			var xml:XML = <order/>
			xml.person_id = person.id;
			xml.notation = notation;
			xml.paid_total = paidTotal;
			xml.created = Utils.getInstance().formatDate(created);
			if (_orderItems != null) {
				xml.order_items = <order_items/>
				for each (var item:OrderItem in _orderItems) {
					xml.order_items.appendChild(item.toXML());
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
		
		public function set orderItems(obj:Array):void {
			_orderItems = obj;
		}
				
		public function get orderItems():Array {
			// if order does not created.
			if (id == 0) {
				return _orderItems;
			}
			return ModelUtils.getInstance().getOrderItemsByOrder(id);
		}
		
		public function set total(obj:Number):void {
            
        }
		
		public function get total():Number {
			var sum:Number = 0;
			for each (var orderItem:OrderItem in orderItems) {
				sum += orderItem.total;
			}
			return sum;
		}
		
		public function get isPaid():Boolean {
			return total <= paidTotal;
		}
		
		public function set isPaid(obj:Boolean):void {
            paidTotal = total;
        }
		
		public function get isOutstanding():Boolean {
			return total > paidTotal;
		}
		
		public function get totalToPaid():Number {
			return total - paidTotal;
		}
	}
}