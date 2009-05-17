package com.j_nid.events {
	
	import flash.events.Event;

	public class ApplicationStateChangeEvent extends Event {
		
		public static var STATE_CHANGE:String = "stateChange";
		public var previousState:uint;
		public var currentState:uint;
		
		public function ApplicationStateChangeEvent(previousState:uint,
													currentState:uint) {
			
			super(STATE_CHANGE);
			this.previousState = previousState;
			this.currentState = currentState;
		}
		
		override public function clone():Event {
			return new ApplicationStateChangeEvent(previousState, currentState);
		}
	}
}