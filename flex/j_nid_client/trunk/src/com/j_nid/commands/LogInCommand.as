package com.j_nid.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SessionDelegate;
	import com.j_nid.controls.ApplicationManager;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	[ResourceBundle("Messages")]
	public class LogInCommand extends RespondCommand {

		private var mgr:ApplicationManager = ApplicationManager.getInstance();
			
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var delegate:SessionDelegate = new SessionDelegate(this);
			delegate.logIn(event.data);
		}
		
		override public function result(event:Object):void {
		    super.result(event);
			mgr.loadAllData();
		}
		
		override public function fault(event:Object):void {
			super.fault(event);
			var resourceMgr:IResourceManager = ResourceManager.getInstance();
			mgr.setState(ApplicationManager.INIT_STATE);
			mgr.showMessage(resourceMgr.getString("Messages", "CanNotLogIn"));
		}
	}
}