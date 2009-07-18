package com.j_nid.models {
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	[ResourceBundle("MakeOrder")]
	
	[Event(name="orderItemCreated", type="com.j_nid.events.JNidEvent")]
	[Event(name="orderItemUpdated", type="com.j_nid.events.JNidEvent")]
	[Event(name="orderItemDeleted", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class OrderItem extends Model {
		
		private static var _orderItems:Array = [];
		private static var _idMap:Object = {};
		public static var loaded:Boolean = false;
		
    	public var unit:uint;
    	public var pricePerUnit:Number;
    	public var costPerUnit:Number;
		public var orderID:uint;
    	public var productID:uint;
    	
    	public static function fromXML(obj:XML):OrderItem {
    		var item:OrderItem = new OrderItem();
    		item.id = obj.id;
    		item.unit = obj.unit;
    		item.pricePerUnit = obj.price_per_unit;
    		item.costPerUnit = obj.cost_per_unit;
    		item.orderID = obj.order_id;
    		item.productID = obj.product_id;
    		return item;
    	}
    	
    	public static function all():Array {
            return _orderItems;
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
            _orderItems.push(obj);
            _idMap[obj.id] = obj;
        }
    	
    	public static function getByID(obj:int):OrderItem {
            return _idMap[obj];
        }
        
        public static function filterByOrder(orderID:uint):Array {
            return _orderItems.filter(
                        function(orderItem:OrderItem, index:int, arr:Array):Boolean {
                            return orderItem.orderID == orderID;
                        });
        }
    	
    	public static function deleteOrderItem(obj:uint):void {
            var orderItem:OrderItem = getByID(obj);
            _orderItems.splice(_orderItems.indexOf(orderItem), 1);
            delete _idMap[orderItem.id];
        }
		
		public function OrderItem() {
			super();
			unit = 0;
			pricePerUnit = 0;
            costPerUnit = 0;
            orderID = 0;
            productID = 0;
		}
		
		public function toXML():XML {
			var xml:XML = <order_item/>
			xml.order_id = orderID;
			xml.product_id = productID;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			xml.cost_per_unit = costPerUnit;
			return xml;
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function get order():Order {
			return Order.getByID(orderID);
		}
		
		public function get product():Product {
			return Product.getByID(productID);
		}
		
		public function set quantity(obj:uint):void {
			var diff:int = obj - quantity;
			unit += product.unit * diff;
		}
		
		public function get quantity():uint {
		    var resMgr:IResourceManager = ResourceManager.getInstance();
		    var depositHutch:ProductType = ProductType.getByName(
                                                resMgr.getString(
                                                    "MakeOrder",
                                                    "DepositHutch"));
            if (product.productType == depositHutch) {
                return 0;
            }
			return Math.max(1, Math.round(unit / product.unit));
		}
		
		public function get total():Number {
			return pricePerUnit * unit;
		}
		
		public function get name():String {
			return product.name;
		}
	}
}