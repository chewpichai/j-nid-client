package com.j_nid.models {
	
	[Bindable]
	public class Product extends Model {
		
		private var _name:String;
    	private var _productType:ProductType;
    	private var _productTypeID:int;
    	private var _unit:uint;
    	private var _pricePerUnit:Number;
    	private var _costPerUnit:Number;
    	private var _isSale:Boolean;
    	
    	public static function fromXML(obj:XML):Product {
    		var product:Product = new Product();
    		product.id = obj.id;
    		product.productTypeID = obj.type_id;
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
			xml.type_id = productTypeID;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			xml.cost_per_unit = costPerUnit;
			xml.is_sale = isSale ? 1:0;
			return xml;
		}
		
		override public function toString():String {
			return name;
		}

/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set name(obj:String):void {
			_name = obj;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function set productType(obj:ProductType):void {
			if (_productType != obj) {
				if (_productType != null) {
					_productType.removeProduct(this);
				}
				_productType = obj;
				_productTypeID = obj.id;
			}
		}
		
		public function get productType():ProductType {
			return _productType;
		}
		
		public function set productTypeID(obj:int):void {
			_productTypeID = obj;
		}
		
		public function get productTypeID():int {
			return _productTypeID;
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