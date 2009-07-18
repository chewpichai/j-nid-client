package com.j_nid.models {
	
	[Event(name="supplyItemCrated", type="com.j_nid.events.JNidEvent")]
	[Event(name="supplyItemDeleted", type="com.j_nid.events.JNidEvent")]
	
	[Bindable]
	public class SupplyItem extends Model {
	    
	    private static var _supplyItems:Array = [];
        private static var _idMap:Object = {};
        public static var loaded:Boolean = false;
		
    	public var unit:uint;
    	public var pricePerUnit:Number;
		public var supplyID:uint;
    	public var productID:uint;
    	
    	public static function fromXML(obj:XML):SupplyItem {
    		var item:SupplyItem = new SupplyItem();
    		item.id = obj.id;
    		item.unit = obj.unit;
    		item.pricePerUnit = obj.price_per_unit;
    		item.supplyID = obj.supply_id;
    		item.productID = obj.product_id;
    		return item;
    	}
    	
    	public static function all():Array {
            return _supplyItems;
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
            _supplyItems.push(obj);
            _idMap[obj.id] = obj;
        }
        
        public static function getByID(obj:int):SupplyItem {
            return _idMap[obj];
        }
        
        public static function filterBySupply(supplyID:uint):Array {
            return _supplyItems.filter(
                        function(item:SupplyItem, index:int, arr:Array):Boolean {
                            return item.supplyID == supplyID;
                        });
        }
        
        public static function deleteSupplyItem(obj:uint):void {
            var item:SupplyItem = getByID(obj);
            _supplyItems.splice(_supplyItems.indexOf(item), 1);
            delete _idMap[item.id];
        }
		
		public function SupplyItem() {
			super();
            unit = 0;
            pricePerUnit = 0;
            supplyID = 0;
            productID = 0;
		}
		
		public function toXML():XML {
			var xml:XML = <supply_item/>
			xml.supply_id = supplyID;
			xml.product_id = productID;
			xml.unit = unit;
			xml.price_per_unit = pricePerUnit;
			return xml;
		}
		
/* ----- get-set function. ------------------------------------------------- */
		
		public function get supply():Supply {
			return Supply.getByID(supplyID);
		}
		
		public function get product():Product {
			return Product.getByID(productID);
		}
		
		public function set quantity(obj:uint):void {
            var diff:int = obj - quantity;
            unit += product.unit * diff;
        }
		
		public function get quantity():int {
			return unit / product.unit;
		}
		
		public function get total():Number {
			return pricePerUnit * unit;
		}
		
		public function get name():String {
			return product.name;
		}
	}
}