package com.j_nid.models {
	
	[Bindable]
	public class Product extends Model {
		
		private var _name:String;
    	private var _type:ProductType;
    	private var _typeID:int;
    	private var _unit:uint;
    	private var _pricePerUnit:Number;
    	private var _costPerUnit:Number;
    	private var _isSale:Boolean;
    	
    	public static function fromXML(obj:XML):Product {
    		var product:Product = new Product();
    		product.id = obj.id;
    		product.typeID = obj.type_id;
			product.name = obj.name;
			product.unit = obj.unit;
			product.costPerUnit = obj.cost_per_unit;
			product.pricePerUnit = obj.price_per_unit;
			product.isSale = Boolean(int(obj.is_sale));
			return product;
    	}
		
		public function Product() {
			super();
		}
		
		public function toXML():XML {
			var xml:XML = <product/>
			xml.name = name;
			xml.type_id = typeID;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			xml.cost_per_unit = costPerUnit;
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
			if (_type != obj) {
				if (_type != null) {
					_type.removeProduct(this);
				}
				_type = obj;
				_typeID = obj.id;
			}
		}
		
		public function get type():ProductType {
			return _type;
		}
		
		public function set typeID(obj:int):void {
			_typeID = obj;
		}
		
		public function get typeID():int {
			return _typeID;
		}
		
		public function set unit(obj:uint):void {
			_unit = obj;
		}
		
		public function get unit():uint {
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