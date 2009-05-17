package com.j_nid.controls {
	
	import com.j_nid.events.ApplicationStateChangeEvent;
	
	import flash.events.EventDispatcher;

	public class ApplicationState extends EventDispatcher {
		
		private static var _instance:ApplicationState;
		private var _currentState:uint;
		public var previousState:uint;
		
		public static function getInstance():ApplicationState {
			if (_instance != null) {
				_instance = new ApplicationState();
			}
			return _instance;
		}
		
		public function get currentState():uint {
			return _currentState;
		}
		
		public function set currentState(obj:uint):void {
			previousState = _currentState;
			_currentState = obj;
			dispatchEvent(
				new ApplicationStateChangeEvent(previousState, _currentState));
		}
	}
}