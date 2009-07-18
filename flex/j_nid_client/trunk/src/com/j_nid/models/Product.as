package com.j_nid.models {
	
	[Event(name="productCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="productUpdated", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class Product extends Model {
	    
	    private static var _products:Array = [];
	    private static var _idMap:Object = {};
	    private static var _nameMap:Object = {};
	    public static var loaded:Boolean = false;
		
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
    	
    	public static function all():Array {
    	    return _products;
    	}
    	
    	public static function add(obj:Object):void {
            if (obj is XML) {
                obj = fromXML(XML(obj));
            } else if (obj is XMLList) {
                for each (var xml:XML in obj) {
                    add(xml);
                }
                return;
            }
            _products.push(obj);
            _idMap[obj.id] = obj;
            _nameMap[obj.name] = obj;
        }
        
        public static function getByID(obj:int):Product {
            return _idMap[obj];
        }
        
        public static function filterByType(productTypeID:int):Array {
            return _products.filter(
                        function(product:Product, index:int, arr:Array):Boolean {
                            return product.productTypeID == productTypeID;
                        });
        }
        
        public static function filterIsSaleByType(productTypeID:int):Array {
            return _products.filter(
                        function(product:Product, index:int, arr:Array):Boolean {
                            return product.isSale &&
                                   product.productTypeID == productTypeID;
                        });
        }
        
        public static function getByName(obj:String):Product {
            return _nameMap[obj];
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
			return ProductType.getByID(productTypeID);
		}
		
		public function set productType(obj:ProductType):void {
			productTypeID = obj.id;
		}
	}
}