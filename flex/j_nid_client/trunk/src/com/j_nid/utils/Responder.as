package com.j_nid.utils {
	
	import mx.rpc.IResponder;

	public class Responder implements IResponder	{
		
		private var _resultHandler:Function;
		private var _faultHandler:Function;
		
		public function Responder(result:Function=null, fault:Function=null) {
			_resultHandler = result;
			_faultHandler = fault;
		}

		public function result(data:Object):void {
            Utils.hideLoading();
			if (_resultHandler != null)
                _resultHandler(data);
		}
		
		public function fault(info:Object):void	{
			if (_faultHandler != null)
                _faultHandler(info);
            trace(info.message.body);
		}
	}
}