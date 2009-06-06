package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.controls.ApplicationManager;
	import com.j_nid.models.Order;
	import com.j_nid.utils.PrintUtils;

	public class OrderCreatedCommand implements ICommand {
		
		private var appMgr:ApplicationManager = ApplicationManager.getInstance();
		
		public function OrderCreatedCommand() {
			
		}

		public function execute(event:CairngormEvent):void {
			appMgr.setState(ApplicationManager.PAYMENT_STATE);
			PrintUtils.printOrder(Order(event.data));
		}
	}
}