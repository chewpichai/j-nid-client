package com.j_nid.controls {
	
	import com.j_nid.models.JNidModelLocator;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	public class ApplicationManager {
		
		public static const LOADING_STATE:String = "loadingState";
		public static const PAYMENT_STATE:String = "paymentState";
		private static var _instance:ApplicationManager;
		private var _model:JNidModelLocator;
		public var mainApp:JNidMain;
		
		public function ApplicationManager() {
			mainApp = JNidMain(Application.application);
			_model = JNidModelLocator.getInstance();
		}
		
		public static function getInstance():ApplicationManager {
			if (_instance == null) {
				_instance = new ApplicationManager();
			}
			return _instance;
		}
		
		public function setState(state:String):void {
			switch (state) {
				case LOADING_STATE:
				    loadingState();
				    break;
				case PAYMENT_STATE:
				    paymentState();
				    break;
			}
		}
		
		private function paymentState():void {
			mainApp.mainView.selectedChild = mainApp["paymentPage"];
		}
		
		private function loadingState():void {
			mainApp.currentState = "loading";
	        var timer:Timer = new Timer(100);
	        timer.addEventListener(TimerEvent.TIMER,
                function(event:TimerEvent):void {
                    if (_model.isLoadComplete) {
                        var t:Timer = Timer(event.currentTarget);
                        t.stop();
                        mainApp.currentState = "main";
                    }
                });
	        timer.start();
		}
		
		public function showMessage(msg:String, title:String=""):void {
			Alert.show(msg, title);
		}
	}
}
