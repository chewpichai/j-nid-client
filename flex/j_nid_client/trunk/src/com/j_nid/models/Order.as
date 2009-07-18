package com.j_nid.models {

    import com.j_nid.utils.Utils;
    
    [Event(name="orderCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="orderDeleted", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class Order extends Model {
	    
	    private static var _orders:Array = [];
	    private static var _idMap:Object = {};
	    public static var loaded:Boolean = false;
		
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
    	
    	public static function all():Array {
            return _orders;
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
            _orders.push(obj);
            _idMap[obj.id] = obj;
        }
        
        public static function getByID(obj:int):Order {
            return _idMap[obj];
        }
        
        public static function filterByPerson(personID:uint):Array {
            return _orders.filter(
                        function(order:Order, index:int, arr:Array):Boolean {
                            return order.personID == personID;
                        });
        }
        
        public static function deleteOrder(obj:uint):void {
            var order:Order = getByID(obj);
            for each (var item:OrderItem in order.orderItems) {
                OrderItem.deleteOrderItem(item.id);
            }
            _orders.splice(_orders.indexOf(order), 1);
            delete _idMap[order.id];
        }
		
		public function Order()  {
			super();
			notation = "";
			personID = 0;
			paidTotal = 0;
			created = new Date();
		}
		
		public function toXML():XML {
			var xml:XML = <order/>
			xml.person_id = person.id;
			xml.notation = notation;
			xml.paid_total = paidTotal;
			xml.created = Utils.formatDate(created);
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
				   Utils.formatDate(created, "DD MMM YYYY") + "]";
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function set person(obj:Person):void {
			personID = obj.id;
		}
		
		public function get person():Person {
			return Person.getByID(personID);
		}
		
		public function set orderItems(obj:Array):void {
			_orderItems = obj;
		}
				
		public function get orderItems():Array {
			// if order does not created.
			if (id == 0) {
				return _orderItems;
			}
			return OrderItem.filterByOrder(id);
		}
		
		public function set total(obj:Number):void {
            
        }
		
		public function get total():Number {
			return Utils.sum(orderItems, "total");
		}
		
		public function set quantityTotal(obj:Number):void {
		    
        }
		
		public function get quantityTotal():Number {
		    return Utils.sum(orderItems, "quantity");
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