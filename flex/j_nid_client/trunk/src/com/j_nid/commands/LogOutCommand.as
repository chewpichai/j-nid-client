package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SessionDelegate;
	import com.j_nid.controls.ApplicationManager;

	public class LogOutCommand extends RespondCommand {
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:SessionDelegate = new SessionDelegate(this);
			delegate.logOut();
		}
		
		override public function result(event:Object):void {
		    super.result(event);
		    var mgr:ApplicationManager = ApplicationManager.getInstance(); 
			mgr.setState(ApplicationManager.INIT_STATE);
		}
	}
}