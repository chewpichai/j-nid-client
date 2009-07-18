package com.j_nid.utils {
	
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	
	[Bindable]
	public class Utils {
		
		private static var instance:Utils;
		private static var dateFormatter:DateFormatter;
		private static var numberFormatter:NumberFormatter;
		
		// defalut format YYYY-MM-DD JJ:NN:SS for use with Django.
		public static function formatDate(date:Date, 
			formatString:String="YYYY-MM-DD JJ:NN:SS"):String {
			
			if (dateFormatter == null) {
			    dateFormatter = new DateFormatter();
			}
			dateFormatter.formatString = formatString;
			return dateFormatter.format(date);
		}
		
		// Use to move date by num days.
		public static function moveDateByDay(date:Date, day:int):Date {
			date = new Date(date.time);
			return new Date(date.setDate(date.date + day));
		}
		
		public static function formatPrice(num:Number):String {
		    if (numberFormatter == null) {
		        numberFormatter = new NumberFormatter();
		    }
			numberFormatter.precision = 2;
			return numberFormatter.format(num);
		}
		
		public static function sum(obj:Object, field:String):Number {
			var sum:Number = 0;
			for each (var item:* in obj) {
                sum += item[field];
            }
			return sum;
		}
		
		public static function convertFirstChar(str:String, isLower:Boolean):String {
		    var firstChar:String = str.charAt(0);
		    if (isLower) {
		        firstChar = firstChar.toLowerCase();
		    } else {
		        firstChar = firstChar.toUpperCase();
		    }
		    str = firstChar + str.slice(1);
		    return str;
		}
	}
}