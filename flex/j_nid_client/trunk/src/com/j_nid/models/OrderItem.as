package com.j_nid.models {
	
	[Bindable]
	public class OrderItem extends Model {
		
		private var _order:Order;
		private var _orderID:int;
    	private var _product:Product;
    	private var _productID:int;
    	private var _unit:int;
    	private var _pricePerUnit:Number;
    	private var _costPerUnit:Number;
    	private var _quantity:int;
    	private var _total:Number;
    	
    	public static function fromXML(obj:XML):OrderItem {
    		var item:OrderItem = new OrderItem();
    		item.id = obj.id;
    		item.unit = obj.unit;
    		item.pricePerUnit = obj.price_per_unit;
    		item.costPerUnit = obj.cost_per_unit;
    		item.total = item.unit * item.pricePerUnit;
    		item.orderID = obj.order_id;
    		item.productID = obj.product_id;
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
			xml.order_id = orderID;
			xml.product_id = productID;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			xml.cost_per_unit = costPerUnit;
			return xml;
		}
		
		public function calcTotal():void {
			total = unit * pricePerUnit;
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set order(obj:Order):void {
			if (obj != null) {
				orderID = obj.id;
			} else {
				orderID = 0;
			}
			_order = obj;
		}
		
		public function get order():Order {
			return _order;
		}
		
		public function set product(obj:Product):void {
			productID = obj.id;
			_product = obj;
		}
		
		public function get product():Product {
			return _product;
		}
		
		public function set unit(obj:int):void {
			_unit = obj;
			if (product != null) {
				_quantity = Math.round(_unit / product.unit);
			}
			calcTotal();
		}
		
		public function get unit():int {
			return _unit;
		}
		
		public function set costPerUnit(obj:Number):void {
			_costPerUnit = obj;
		}
		
		public function get costPerUnit():Number {
			return _costPerUnit;
		}
		
		public function set pricePerUnit(obj:Number):void {
			_pricePerUnit = obj;
			calcTotal();
		}
		
		public function get pricePerUnit():Number {
			return _pricePerUnit;
		}
		
		public function set quantity(obj:int):void {
			var diff:int = obj - quantity;
			if (product != null) {
				_unit = unit + diff * product.unit;
			}
			_quantity = obj;
			calcTotal();
		}
		
		public function get quantity():int {
			return _quantity;
		}
		
		public function set total(obj:Number):void {
			_total = obj;
		}
		
		public function get total():Number {
			return _total;
		}
		
		public function set orderID(obj:int):void {
			_orderID = obj;
		}
		
		public function get orderID():int {
			return _orderID;
		}
		
		public function set productID(obj:int):void {
			_productID = obj;
		}
		
		public function get productID():int {
			return _productID;
		}
		
		public function get name():String {
			return product.name;
		}
	}
}