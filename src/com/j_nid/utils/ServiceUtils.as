package com.j_nid.utils {
    
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.http.HTTPService;
    
    public class ServiceUtils {
        
        private static var _serverAddr:String;
        
        public static function set serverAddr(addr:String):void {
            _serverAddr = "http://" + addr + "/j-nid";
        }
        
        public static function send(url:String, method:String,
                                    responder:IResponder=null,
                                    request:XML=null):void {
            
            Utils.showLoading();
            var service:HTTPService = new HTTPService();
            service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
            service.contentType = HTTPService.CONTENT_TYPE_FORM;
            service.method = method;
            service.url = _serverAddr + url;
            var xml:XML = <request/>
            if (method == "PUT" || method == "DELETE") {
                xml.method = method;
            }
            if (request != null || method == "DELETE") {
                if (request != null) {
                    xml.appendChild(request);
                }
                service.request = xml;
                service.contentType = HTTPService.CONTENT_TYPE_XML;
            }
            var call:AsyncToken = service.send();
            if (responder != null) {
                call.addResponder(responder);
            }
        }
    }
}