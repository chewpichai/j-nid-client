package com.j_nid.models {
	
	import flash.events.Event;
	
	[Event(name="change", type="flash.events.Event")]
	
	[Bindable]
	public class OrderItem extends Model {
		
		private var _order:Order;
    	private var _product:Product;
    	private var _unit:int;
    	private var _pricePerUnit:Number;
    	private var _quantity:int;
    	private var _amount:Number;
		
		public function OrderItem(obj:Product) {
			super();
			product = obj;
			pricePerUnit = obj.pricePerUnit;
			quantity = 1;
			unit = obj.unit;
			amount = calcAmount();
			addEventListener(Event.CHANGE, changeListener);
		}
		
		public function toXML():XML {
			var xml:XML = <order_item/>
			xml.product = product.id;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			return xml;
		}
		
		private function changeListener(e:Event):void {
			amount = calcAmount();
		}
		
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
		
		public function get name():String {
			return _product.name;
		}
		
		public function set unit(obj:Object):void {
			_unit = int(obj);
			_quantity = _unit / product.unit;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get unit():int {
			return _unit;
		}
		
		public function set pricePerUnit(obj:Object):void {
			_pricePerUnit = Number(obj);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get pricePerUnit():Number {
			return _pricePerUnit;
		}
		
		public function set quantity(obj:Object):void {
			var diff:int = int(obj) - _quantity;
			_quantity = int(obj);
			_unit += product.unit * diff;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get quantity():int {
			return _quantity;
		}
		
		public function set amount(obj:Object):void {
			_amount = Number(obj);
		}
		
		public function get amount():Number {
			return _amount;
		}
		
		public function calcAmount():Number {
			return unit * pricePerUnit;
		}
	}
}