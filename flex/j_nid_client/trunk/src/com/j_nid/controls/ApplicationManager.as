package com.j_nid.controls {
	
	public class ApplicationManager {
		
		private static var _instance:ApplicationManager;
		
		public static function getInstance():ApplicationManager {
			if (_instance != null) {
				_instance = new ApplicationManager();
			}
			return _instance;
		}
	}
}