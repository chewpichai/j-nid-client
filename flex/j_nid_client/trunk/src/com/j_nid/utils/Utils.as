package com.j_nid.utils {
	
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	
	[Bindable]
	public class Utils {
		
		private static var _instance:Utils;
		private static var dateFormat:DateFormatter;
		private static var numberFormat:NumberFormatter;
		
		public function Utils() {
			dateFormat = new DateFormatter();
			numberFormat = new NumberFormatter();
		}
		
		public static function getInstance():Utils {
			if (_instance == null) {
				_instance = new Utils();
			}
			return _instance;
		}
		
		public function formatDate(date:Date, 
			formatString:String="DD-MM-YYYY JJ:NN:SS"):String {
			
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
	}
}