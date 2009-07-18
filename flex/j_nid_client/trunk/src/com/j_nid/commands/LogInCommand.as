package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SessionDelegate;
	import com.j_nid.controls.ApplicationManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	[ResourceBundle("Messages")]
	public class LogInCommand extends RespondCommand {

		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:SessionDelegate = new SessionDelegate(this);
			delegate.logIn(event.data);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			var mgr:ApplicationManager = ApplicationManager.getInstance();
			mgr.setState(ApplicationManager.LOADING_STATE);
			mgr.loadAllData();
		}
		
		override public function fault(event:Object):void {
			super.fault(event);
			var mgr:ApplicationManager = ApplicationManager.getInstance();
			var resourceMgr:IResourceManager = ResourceManager.getInstance();
			mgr.showMessage(resourceMgr.getString("Messages", "CanNotLogIn"));
		}
	}
}