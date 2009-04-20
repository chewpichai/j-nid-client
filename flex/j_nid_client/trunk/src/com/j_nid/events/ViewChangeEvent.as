package com.j_nid.events {
	
	import flash.display.DisplayObject;
	import flash.events.Event;

	public class ViewChangeEvent extends Event {
		
		public static var VIEW_CHANGE:String = "viewChange";
		public var relatedObject:DisplayObject;
		
		public function ViewChangeEvent(relatedObject:DisplayObject) {
			super(VIEW_CHANGE);
			this.relatedObject = relatedObject;
		}
		
		override public function clone():Event {
			return new ViewChangeEvent(relatedObject);
		}
	}
}