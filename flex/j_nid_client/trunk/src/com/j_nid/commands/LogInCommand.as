package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.business.SessionDelegate;
	import com.j_nid.controls.ApplicationManager;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	[ResourceBundle("Messages")]
	public class LogInCommand implements ICommand, IResponder {
		
		private var mgr:ApplicationManager = ApplicationManager.getInstance();
		private var resourceMgr:IResourceManager = ResourceManager.getInstance();
		
		public function LogInCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			var delegate:SessionDelegate = new SessionDelegate(this);
			delegate.logIn(event.data);
		}
		
		public function result(event:Object):void {
			mgr.setState(ApplicationManager.LOADING_STATE);
		}
		
		public function fault(event:Object):void {
			mgr.showMessage(resourceMgr.getString("Messages", "CanNotLogIn"));
		}
	}
}