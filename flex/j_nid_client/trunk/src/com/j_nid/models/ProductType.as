package com.j_nid.models {
    
    import com.j_nid.utils.ModelUtils;
    
    import mx.resources.ResourceManager;
    
    [ResourceBundle("ProductPage")]
    
    [Bindable]
    public class ProductType extends Model {
        
        public static const ALL:ProductType =
            new ProductType(ResourceManager.getInstance().getString(
                                "ProductPage", "All"));
        
        private var _name:String;
        private var _color:uint;
        
        public static function fromXML(obj:XML):ProductType {
            var productType:ProductType = new ProductType();
            productType.id = obj.id;
            productType.name = obj.name;
            productType.color = obj.color;
            return productType;
        }
        
        public function ProductType(name:String="") {
            super();
            this.name = name;
            color = 0;
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
        
        public function get products():Array {
            var products:Array = 
                ModelUtils.getInstance().getProductsByProductType(id);
            products.sortOn(["name"]);
            return products;
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