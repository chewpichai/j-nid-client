package com.j_nid.events
{
    import flash.events.Event;
    
    public class DiffEvent extends Event {
        
        public static const NUMBER_CHANGE:String = "numberChange";
        public var diff:Number;
        
        public function DiffEvent(diff:Number) {
            super(NUMBER_CHANGE, true);
            this.diff = diff;
        }
        
        override public function clone():Event {
            return new DiffEvent(diff);
        }
    }
}