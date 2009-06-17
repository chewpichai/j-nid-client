package com.j_nid.models {
	
	import com.j_nid.events.JNidEvent;
	import com.j_nid.utils.ModelUtils;
	
	[Bindable]
	public class OrderItem extends Model {
		
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
		
		public function OrderItem() {
			super();
			unit = 0;
			pricePerUnit = 0;
            costPerUnit = 0;
            orderID = 0;
            productID = 0;
            //
            createEvent = JNidEvent.CREATE_ORDER_ITEM;
            updateEvent = JNidEvent.UPDATE_ORDER_ITEM;
            deleteEvent = JNidEvent.DELETE_ORDER_ITEM;
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
			return ModelUtils.getInstance().getOrder(orderID);
		}
		
		public function get product():Product {
			return ModelUtils.getInstance().getProduct(productID);
		}
		
		public function set quantity(obj:uint):void {
			var diff:int = obj - quantity;
			unit += product.unit * diff;
		}
		
		public function get quantity():uint {
			return Math.round(unit / product.unit);
		}
		
		public function get total():Number {
			return pricePerUnit * unit;
		}
		
		public function get name():String {
			return product.name;
		}
	}
}