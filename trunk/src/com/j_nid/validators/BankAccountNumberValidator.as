package com.j_nid.validators {
	
	import mx.validators.Validator;
	import mx.validators.ValidationResult;

	public class BankAccountNumberValidator extends Validator {
		
		private var _allowedFormatChars:String;
		
		public function BankAccountNumberValidator() {
			super();
			allowedFormatChars = "-";
		}
		
		override protected function doValidation(value:Object):Array {
			var results:Array = super.doValidation(value);
			var val:String = value ? String(value) : "";
			if (results.length > 0 || ((val.length == 0) && !required)) {
				return results;
			}
			return BankAccountNumberValidator.validateBankAccountNumber(this, value, null);
		}
		
		public static function validateBankAccountNumber(validator:BankAccountNumberValidator, value:Object, baseField:String):Array {
			var results:Array = [];
			var allowedFormatChars:String = validator.allowedFormatChars;
			var valid:String =  DECIMAL_DIGITS + allowedFormatChars;
			var len:int = value.toString().length;
			var digitLen:int = 0;
			var n:int;
			var i:int;
			n = allowedFormatChars.length;
			for (i = 0; i < n; i++)	{
				if (DECIMAL_DIGITS.indexOf(allowedFormatChars.charAt(i)) != -1)	{
					var message:String = "Your format chars can not contains digits.";
					throw new Error(message);
				}
			}
			for (i = 0; i < len; i++) {
				var temp:String = "" + value.toString().substring(i, i + 1);
				if (valid.indexOf(temp) == -1) {
					results.push(new ValidationResult(true, baseField, "invalidChar", "Your bank account number contains invalid characters."));
					return results;
				}
				if (valid.indexOf(temp) < DECIMAL_DIGITS.length)
					digitLen++;
			}
			if (digitLen != 10) {
				results.push(new ValidationResult(true, baseField, "wrongLength", "Your bank account number must contain 10 digits."));
				return results;
			}
			return results;
		}
		
		public function get allowedFormatChars():String {
			return _allowedFormatChars;
		}

		public function set allowedFormatChars(obj:String):void {
			_allowedFormatChars = obj;
		}
	}
}