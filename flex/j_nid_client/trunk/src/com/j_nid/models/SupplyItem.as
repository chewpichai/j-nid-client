package com.j_nid.models {
	
	[Bindable]
	public class SupplyItem extends Model {
		
		private var _supply:Supply;
		private var _supplyID:int;
    	private var _product:Product;
    	private var _productID:int;
    	private var _unit:int;
    	private var _pricePerUnit:Number;
    	private var _quantity:int;
    	private var _total:Number;
    	
    	public static function fromXML(obj:XML):SupplyItem {
    		var item:SupplyItem = new SupplyItem();
    		item.id = obj.id;
    		item.unit = obj.unit;
    		item.pricePerUnit = obj.price_per_unit;
    		item.total = item.unit * item.pricePerUnit;
    		item.supplyID = obj.supply_id;
    		item.productID = obj.product_id;
    		return item;
    	}
		
		public function SupplyItem(product:Product=null) {
			super();
			if (product != null) {
				this.product = product;
				pricePerUnit = product.costPerUnit;
				unit = product.unit;
			}
			_quantity = 1;
		}
		
		public function toXML():XML {
			var xml:XML = <supply_item/>
			xml.supply_id = supplyID;
			xml.product_id = productID;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			return xml;
		}
		
		public function calcTotal():void {
			total = unit * pricePerUnit;
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set supply(obj:Supply):void {
			if (obj != null) {
				supplyID = obj.id;
			} else {
				supplyID = 0;
			}
			_supply = obj;
		}
		
		public function get supply():Supply {
			return _supply;
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
		
		public function set supplyID(obj:int):void {
			_supplyID = obj;
		}
		
		public function get supplyID():int {
			return _supplyID;
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