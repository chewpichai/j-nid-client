package com.j_nid.models {
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ProductType extends Model {
		
		private var _name:String;
		private var _products:ArrayCollection;
		
		public static function fromXML(obj:XML):ProductType {
			var productType:ProductType = new ProductType();
			productType.id = int(obj.id);
			productType.name = obj.name;
			return productType;
		}
		
		public function ProductType() {
			super();
			products = new ArrayCollection();
		}
		
		public function addProduct(product:Product):void {
			product.type = this;
			products.addItem(product);
		}
		
		public function get onSaleProducts():ArrayCollection {
			products.filterFunction = function(item:Object):Boolean {
				return item.isSale;
			};
			products.refresh();
			return products;
		}
		
		public function toXML():XML {
			var xml:XML = <product_type/>
			if (id != 0) {
				xml.id = id;
			}
			xml.name = name;
			return xml;
		}
		
/* ----- get-set function. --------------------------------------------------------------------- */
		
		public function set products(obj:ArrayCollection):void {
			_products = obj;
		}
		
		public function get products():ArrayCollection {
			return _products;
		}
		
		public function set name(obj:String):void {
			_name = obj;
		}
		
		public function get name():String {
			return _name;
		}
	}
}