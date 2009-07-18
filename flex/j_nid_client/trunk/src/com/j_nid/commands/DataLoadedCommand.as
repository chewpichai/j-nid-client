package com.j_nid.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.j_nid.controls.ApplicationManager;
	

    public class DataLoadedCommand implements ICommand {
        
        public function execute(event:CairngormEvent):void {
            var mgr:ApplicationManager = ApplicationManager.getInstance();
            if (mgr.isDataloaded()) {
                mgr.setState(ApplicationManager.MAIN_STATE);
            }
        }
    }
}