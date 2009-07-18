package com.j_nid.models {
    
    import com.j_nid.events.JNidEvent;
    
    [ResourceBundle("ProductPage")]
    
    [Event(name="productTypeCreated", type="com.j_nid.events.JNidEvent")]
    [Event(name="productTypeUpdated", type="com.j_nid.events.JNidEvent")]
    
    [Bindable]
    public class ProductType extends Model {
        
        private static var _allType:ProductType;
        private static var _productTypes:Array = [];
        private static var _productTypesWithAll:Array = [ALL_TYPE];
        private static var _idMap:Object = {};
        private static var _nameMap:Object = {};
        public static var loaded:Boolean = false;
        
        private var _name:String;
        private var _color:uint;
        
        public static function fromXML(obj:XML):ProductType {
            var productType:ProductType = new ProductType();
            productType.id = obj.id;
            productType.name = obj.name;
            productType.color = obj.color;
            return productType;
        }
        
        public static function all(withAll:Boolean=false):Array {
            if (withAll) {
                return _productTypesWithAll;
            }
            return _productTypes;
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
            _productTypes.push(obj);
            _productTypesWithAll.push(obj);
            _idMap[obj.id] = obj;
            _nameMap[obj.name] = obj;
        }
        
        public static function getByID(obj:int):ProductType {
            return _idMap[obj];
        }
        
        public static function getByName(obj:String):ProductType {
            return _nameMap[obj];
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
        
        public static function get ALL_TYPE():ProductType {
            if (_allType == null) {
                _allType = new ProductType(resMgr.getString(
                                                "ProductPage", "All")); 
            }
            return _allType;
        }
        
        public function get products():Array {
            var products:Array = Product.filterByType(id);
            products.sortOn(["name"]);
            return products;
        }
        
        public function get isSaleProducts():Array {
            var products:Array = Product.filterIsSaleByType(id);
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