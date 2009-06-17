package com.j_nid.controls {
    
    import com.j_nid.utils.ModelUtils;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import mx.controls.Alert;
    import mx.core.Application;
    
    public class ApplicationManager {
        
        public static const LOADING_STATE:String = "loadingState";
        public static const PAYMENT_STATE:String = "paymentState";
        private static var instance:ApplicationManager;
        
        public var mainApp:JNidMain;
        
        public function ApplicationManager() {
            mainApp = JNidMain(Application.application);
        }
        
        public static function getInstance():ApplicationManager {
            if (instance == null) {
                instance = new ApplicationManager();
            }
            return instance;
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
                    if (ModelUtils.getInstance().isLoadComplete) {
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
        
        public function showConfirm(msg:String, title:String,
                                    closeHandler:Function):void {
            
            Alert.show(msg, title, (Alert.OK | Alert.CANCEL), null,
                closeHandler);
        }
    }
}
