package com.j_nid.utils {
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	public class ServiceUtils {
		
		public static const ROOT_URL:String = "http://127.0.0.1:8000/j-nid";
		
		public static function send(url:String, method:String, responder:IResponder=null,
			request:XML=null):void {
			
			var service:HTTPService = new HTTPService();
			service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			service.contentType = HTTPService.CONTENT_TYPE_FORM;
			service.method = method;
			service.url = ROOT_URL + url;
			if (request != null) {
				var xml:XML = <request/>
				xml.appendChild(request);
				service.request = xml;
				service.contentType = HTTPService.CONTENT_TYPE_XML;
			}
			if (method == "PUT" || method == "DELETE") {
				service.request.method = method;
			}
			var call:AsyncToken = service.send();
			if (responder != null) {
				call.addResponder(responder);
			}
		} 
	}
}