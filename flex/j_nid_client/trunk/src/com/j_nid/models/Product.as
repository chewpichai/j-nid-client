package com.j_nid.models {
	
	import com.j_nid.utils.ModelUtils;
	
	[Bindable]
	public class Product extends Model {
		
		public var name:String;
    	public var productTypeID:uint;
    	public var unit:uint;
    	public var pricePerUnit:Number;
    	public var costPerUnit:Number;
    	public var isSale:Boolean;
    	
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
			productTypeID = 0;
            name = "";
            unit = 0;
            costPerUnit = 0;
            pricePerUnit = 0;
            isSale = false;
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

/* ----- get-set function. ------------------------------------------------- */
		
		public function get productType():ProductType {
			return ModelUtils.getInstance().getProductType(productTypeID);
		}
		
		public function set productType(obj:ProductType):void {
			productTypeID = obj.id;
		}
	}
}