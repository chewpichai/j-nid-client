package com.j_nid.models {
	
	import com.j_nid.events.JNidEvent;
	import com.j_nid.utils.ModelUtils;
	
	[Bindable]
	public class SupplyItem extends Model {
		
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
		
		public function SupplyItem() {
			super();
            unit = 0;
            pricePerUnit = 0;
            supplyID = 0;
            productID = 0;
            //
            createEvent = JNidEvent.CREATE_SUPPLY_ITEM;
            updateEvent = JNidEvent.UPDATE_SUPPLY_ITEM;
            deleteEvent = JNidEvent.DELETE_SUPPLY_ITEM;
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
			return ModelUtils.getInstance().getSupply(supplyID);
		}
		
		public function get product():Product {
			return ModelUtils.getInstance().getProduct(productID);
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