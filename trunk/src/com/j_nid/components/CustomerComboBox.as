package com.j_nid.components {
    
    import com.j_nid.utils.Responder;
    import com.j_nid.utils.ServiceUtils;
    
    import mx.collections.XMLListCollection;
    import mx.rpc.events.ResultEvent;
    
    import spark.components.ComboBox;
    
    public class CustomerComboBox extends ComboBox {
        
        public function CustomerComboBox() {
            super();
            labelField = "name";
            loadCustomers();
        }
        
        private function loadCustomers():void {
            var responder:com.j_nid.utils.Responder =
                new com.j_nid.utils.Responder(customersResultHandler);
            var attrs:String = "attrs=id,name,outstanding_total";
            var filters:String = "filters=is_customer=1";
            ServiceUtils.send("/people/?" + attrs + "&" + filters,
                "GET", responder);
        }
        
        private function customersResultHandler(data:Object):void {
            var resultEvent:ResultEvent = ResultEvent(data);
            dataProvider = 
                new XMLListCollection(resultEvent.result.children());
            dataProvider.addItemAt(new XML(), 0);
        }
    }
}