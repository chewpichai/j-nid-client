package com.j_nid.models {
	
	import flash.events.Event;
	
	[Event(name="change", type="flash.events.Event")]
	
	[Bindable]
	public class OrderItem extends Model {
		
		private var _order:Order;
    	private var _product:Product;
    	private var _unit:int;
    	private var _pricePerUnit:Number;
    	private var _quantity:uint;
    	private var _total:Number;
    	
    	public static function fromXML(obj:XML):OrderItem {
    		var item:OrderItem = new OrderItem();
    		item.id = obj.id;
    		item.unit = obj.unit;
    		item.pricePerUnit = obj.price_per_unit;
    		return item;
    	}
		
		public function OrderItem(product:Product=null) {
			super();
			if (product != null) {
				this.product = product;
				pricePerUnit = product.pricePerUnit;
				unit = product.unit;
			}
			_quantity = 1;
		}
		
		public function toXML():XML {
			var xml:XML = <order_item/>
			xml.order_id = order.id;
			xml.product_id = product.id;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			return xml;
		}
		
		public function calcTotal():void {
			total = unit * pricePerUnit;
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set order(obj:Order):void {
			_order = obj;
		}
		
		public function get order():Order {
			return _order;
		}
		
		public function set product(obj:Product):void {
			_product = obj;
		}
		
		public function get product():Product {
			return _product;
		}
		
		public function set unit(obj:int):void {
			_unit = obj;
			if (product != null) {
				_quantity = _unit / product.unit;
			}
			calcTotal();
		}
		
		public function get unit():int {
			return _unit;
		}
		
		public function set pricePerUnit(obj:Number):void {
			_pricePerUnit = obj;
			calcTotal();
		}
		
		public function get pricePerUnit():Number {
			return _pricePerUnit;
		}
		
		public function set quantity(obj:uint):void {
			var diff:int = obj - quantity;
			if (product != null) {
				_unit = unit + diff * product.unit;
			}
			_quantity = obj;
			calcTotal();
		}
		
		public function get quantity():uint {
			return _quantity;
		}
		
		public function set total(obj:Number):void {
			_total = obj;
		}
		
		public function get total():Number {
			return _total;
		}
		
		public function get name():String {
			return product.name;
		}
	}
}