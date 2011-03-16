package com.j_nid.components {
    
    import com.j_nid.utils.Utils;
    import com.j_nid.validators.DateTimeValidator;
    
    import mx.events.ValidationResultEvent;
    
    import spark.components.TextInput;
    
    public class DateTimeInput extends TextInput {
        
        private var validator:DateTimeValidator;
        
        public function DateTimeInput() {
            super();
            validator = new DateTimeValidator();
            validator.source = this;
            validator.property = "text";
            validator.triggerEvent = "change";
        }
        
        public function get dateString():String {
            var _date:Date = date;
            if (_date) {
                return Utils.formatDate(_date);
            }
            return "";
        }
        
        public function get date():Date {
            var event:ValidationResultEvent = validator.validate();
            if (event.type == ValidationResultEvent.VALID) {
                var dateTimeRe:RegExp = /^(\d{1,2})-(\d{1,2})-(\d{4}) (\d{1,2}):(\d{1,2})$/;
                var results:Array = dateTimeRe.exec(text);
                results.shift();
                var year:int = results[2];
                if (year > 2500)
                    year -= 543;
                var month:int = int(results[1]) - 1;
                return new Date(year, month, results[0], results[3], results[4]);
            }
            return null;
        }
    }
}