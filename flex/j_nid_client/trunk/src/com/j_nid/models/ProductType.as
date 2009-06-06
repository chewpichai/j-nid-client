package com.j_nid.models {
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	[Bindable]
	public class ProductType extends Model {
		
		private var _name:String;
		private var _color:uint;
		private var _products:ArrayCollection;
		
		public static function fromXML(obj:XML):ProductType {
			var productType:ProductType = new ProductType();
			productType.id = obj.id;
			productType.name = obj.name;
			productType.color = obj.color;
			return productType;
		}
		
		public function ProductType(id:int=0, name:String="", color:uint=0) {
			super();
			this.id = id;
			this.name = name;
			this.color = color;
			products = new ArrayCollection();
		}
		
		public function addProduct(product:Product):void {
			product.productType = this;
			products.addItem(product);
		}
		
		public function removeProduct(product:Product):void {
			products.removeItemAt(products.getItemIndex(product));
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
			xml.name = name;
			xml.color = color;
			return xml;
		}
		
		override public function toString():String {
			return name;
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function set products(obj:ArrayCollection):void {
			_products = obj;
			var sort:Sort = new Sort();
			sort.fields = [new SortField("name")];
			_products.sort = sort;
			_products.refresh();
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
		
		public function set color(obj:uint):void {
			_color = obj;
		}
		
		public function get color():uint {
			return _color;
		}
	}
}