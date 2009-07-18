package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import mx.rpc.IResponder;

	public class RespondCommand implements ICommand, IResponder {
		
		public function RespondCommand() {
		    			
		}
		
		public function execute(event:CairngormEvent):void {
			
		}
		
		public function result(event:Object):void {
			
		}
		
		public function fault(event:Object):void {
            trace(event.message);
        }
    }
}