package com.j_nid.models {
	
	[Bindable]
	public class Product extends Model {
		
		private var _name:String;
    	private var _type:ProductType;
    	private var _unit:int;
    	private var _pricePerUnit:Number;
    	private var _isSale:Boolean;
    	
    	public static function fromXML(obj:XML):Product {
    		var product:Product = new Product();
    		product.id = int(obj.id);
			product.name = obj.name;
			product.unit = int(obj.unit);
			product.pricePerUnit = Number(obj.price_per_unit);
			product.isSale = Boolean(int(obj.is_sale));
			return product;
    	}
		
		public function Product() {
			super();
		}
		
		public function toXML():XML {
			var xml:XML = <product/>
			xml.name = name;
			xml.type_id = type.id;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			xml.is_sale = isSale ? 1:0;
			return xml;
		}
		
		public function toString():String {
			return name;
		}

/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set name(obj:String):void {
			_name = obj;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function set type(obj:ProductType):void {
			_type = obj;
		}
		
		public function get type():ProductType {
			return _type;
		}
		
		public function set unit(obj:int):void {
			_unit = obj;
		}
		
		public function get unit():int {
			return _unit;
		}
		
		public function set pricePerUnit(obj:Number):void {
			_pricePerUnit = obj;
		}
		
		public function get pricePerUnit():Number {
			return _pricePerUnit;
		}
		
		public function set isSale(obj:Boolean):void {
			_isSale = obj;
		}
		
		public function get isSale():Boolean {
			return _isSale;
		}
	}
}