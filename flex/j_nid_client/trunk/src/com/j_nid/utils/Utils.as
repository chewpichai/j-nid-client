package com.j_nid.utils {
	
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	
	[Bindable]
	public class Utils {
		
		private static var instance:Utils;
		private static var dateFormat:DateFormatter;
		private static var numberFormat:NumberFormatter;
		
		public function Utils() {
			dateFormat = new DateFormatter();
			numberFormat = new NumberFormatter();
		}
		
		public static function getInstance():Utils {
			if (instance == null) {
				instance = new Utils();
			}
			return instance;
		}
		
		// defalut format YYYY-MM-DD JJ:NN:SS for use with Django.
		public function formatDate(date:Date, 
			formatString:String="YYYY-MM-DD JJ:NN:SS"):String {
			
			dateFormat.formatString = formatString;
			return dateFormat.format(date);
		}
		
		// Use to move date by num days.
		public function moveDateByDay(date:Date, day:int):Date {
			date = new Date(date.time);
			return new Date(date.setDate(date.date + day));
		}
		
		public function formatPrice(num:Number):String {
			numberFormat.precision = 2;
			return numberFormat.format(num);
		}
		
		public function sum(obj:Object, field:String):Number {
			var sum:Number = 0;
			for each (var item:* in obj) {
                sum += item[field];
            }
			return sum;
		}
	}
}