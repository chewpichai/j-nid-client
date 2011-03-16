package com.j_nid.validators {
    
    import mx.utils.StringUtil;
    import mx.validators.ValidationResult;
    import mx.validators.Validator;
    
    public class DateTimeValidator extends Validator {
        
        public static function validateDateTime(validator:DateTimeValidator, value:Object, baseField:String):Array {
            var errors:Array = [];
            var val:String = StringUtil.trim(String(value));
            var dateTimeRe:RegExp = /^(\d{1,2})-(\d{1,2})-(\d{4}) (\d{1,2}):(\d{1,2})$/;
            var results:Array = dateTimeRe.exec(val);
            if (!results || results.length != 6) {
                errors.push(new ValidationResult(true, baseField, "invalidFormat", "Only 'DD-MM-YYYY JJ:NN' format."));
                return errors;
            }
            results.shift();
            var year:int = results[2];
            if (year > 2500)
                year -= 543;
            var time:Number = Date.UTC(year, results[1]-1, results[0], results[3], results[4]);
            if (isNaN(time)) {
                errors.push(new ValidationResult(true, baseField, "invalidFormat", "Only 'DD-MM-YYYY JJ:NN' format."));
                return errors;
            }
            return errors;
        }
        
        public function DateTimeValidator() {
            super();
        }
        
        override protected function doValidation(value:Object):Array {
            return validateDateTime(this, value, null);
        }
    }
}