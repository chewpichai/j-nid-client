package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SessionDelegate;
	import mx.rpc.IResponder;

	public class LogOutCommand implements ICommand, IResponder {
		
		public function LogOutCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:SessionDelegate = new SessionDelegate(this);
			delegate.logOut();
		}
		
		public function result(event:Object):void {
			trace(event);
		}
		
		public function fault(event:Object):void {
			trace(event.message);
		}
	}
}