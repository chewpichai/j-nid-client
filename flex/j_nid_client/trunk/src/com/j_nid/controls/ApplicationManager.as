package com.j_nid.controls {
    
    import com.j_nid.events.JNidEvent;
    import com.j_nid.models.BankAccount;
    import com.j_nid.models.Order;
    import com.j_nid.models.OrderItem;
    import com.j_nid.models.Payment;
    import com.j_nid.models.Person;
    import com.j_nid.models.PhoneNumber;
    import com.j_nid.models.Product;
    import com.j_nid.models.ProductType;
    import com.j_nid.models.Supply;
    import com.j_nid.models.SupplyItem;
    import com.j_nid.utils.CairngormUtils;
    
    import mx.controls.Alert;
    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.managers.PopUpManager;
    
    public class ApplicationManager {
        
        public static const INIT_STATE:String = "";
        public static const LOADING_STATE:String = "loadingState";
        public static const PAYMENT_STATE:String = "paymentState";
        public static const MAIN_STATE:String = "mainState";
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
        
        public function loadAllData():void {
            if (!isDataloaded()) {
                CairngormUtils.dispatchEvent(JNidEvent.LIST_PRODUCT_TYPE);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_PRODUCT);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_PERSON);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_BANK_ACCOUNT);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_ORDER);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_ORDER_ITEM);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_SUPPLY);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_SUPPLY_ITEM);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_PHONE_NUMBER);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_PAYMENT);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_BANK_NAME);
                CairngormUtils.dispatchEvent(JNidEvent.LIST_PHONE_TYPE);
            }
        }
        
        public function isDataloaded():Boolean {
            return BankAccount.loaded && Order.loaded && OrderItem.loaded &&
                   Payment.loaded && Person.loaded && PhoneNumber.loaded &&
                   Product.loaded && ProductType.loaded && Supply.loaded &&
                   SupplyItem.loaded && BankAccount.bankNameLoaded &&
                   PhoneNumber.phoneTypeLoaded; 
        }
        
        public function setState(state:String):void {
            switch (state) {
                case INIT_STATE:
                    initState();
                    break;
                case MAIN_STATE:
                    mainState();
                    break;
                case LOADING_STATE:
                    loadingState();
                    break;
                case PAYMENT_STATE:
                    paymentState();
                    break;
            }
        }
        
        private function initState():void {
            mainApp.currentState = "";
        }
        
        private function mainState():void {
            mainApp.currentState = "main";
        }
        
        private function paymentState():void {
            mainApp.mainView.selectedChild = mainApp["paymentPage"];
        }
        
        private function loadingState():void {
            mainApp.currentState = "loading";
        }
        
        public function showMessage(msg:String, title:String=""):void {
            Alert.show(msg, title);
        }
        
        public function showConfirm(msg:String, title:String,
                                    closeHandler:Function):void {
            
            Alert.show(msg, title, (Alert.OK | Alert.CANCEL), null,
                closeHandler);
        }
        
        public function createPopUp(className:Class):IFlexDisplayObject {
            var ui:IFlexDisplayObject = 
                PopUpManager.createPopUp(mainApp, className, true);
            PopUpManager.centerPopUp(ui);
            return ui;
        }
    }
}
