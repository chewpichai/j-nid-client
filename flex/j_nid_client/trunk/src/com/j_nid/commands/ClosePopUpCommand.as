package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import mx.managers.PopUpManager;

    public class ClosePopUpCommand implements ICommand {
        
        public function execute(event:CairngormEvent):void {
            PopUpManager.removePopUp(event.data);
        }
    }
}