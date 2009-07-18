package com.j_nid.models {
	
	import com.j_nid.events.JNidEvent;
	import com.j_nid.utils.CairngormUtils;
	import com.j_nid.utils.Utils;
	
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class Model extends EventDispatcher {
		
		private static var _resMgr:IResourceManager;
		
		public var id:uint;
		private var className:String;
		
		public function Model()	{
			super();
            id = 0;
            className = getQualifiedClassName(this).split("::")[1];
        }
        
        public function save():void {
            if (id > 0) {
                CairngormUtils.dispatchEvent("update" + className, this);
            } else {
                CairngormUtils.dispatchEvent("create" + className, this);
            }
        }
        
        public function remove():void {
            CairngormUtils.dispatchEvent("delete" + className, this);
        }
        
        protected function internalDispatch(eventName:String):void {
            var event:JNidEvent = new JNidEvent(eventName, this);
            dispatchEvent(event);
        }
        
        public function dispatchCreated():void {
            internalDispatch(Utils.convertFirstChar(className, true) + "Created");
        }
        
        public function dispatchUpdated():void {
            internalDispatch(Utils.convertFirstChar(className, true) + "Updated");
        }
        
        public function dispatchDeleted():void {
            internalDispatch(Utils.convertFirstChar(className, true) + "Deleted");
        }
        
        protected static function get resMgr():IResourceManager {
            if (_resMgr == null) {
                _resMgr = ResourceManager.getInstance();
            }
            return _resMgr;
        }
    }
}