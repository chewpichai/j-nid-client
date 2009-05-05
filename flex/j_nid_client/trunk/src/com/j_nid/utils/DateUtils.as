package com.j_nid.utils {
	import mx.formatters.DateFormatter;
	
	
	public class DateUtils {
		
		public static var dateFormat:DateFormatter = new DateFormatter();
		
		public static function format(date:Date, 
			formatString:String="YYYY-MM-DD JJ:NN:SS"):String {
			
			dateFormat.formatString = formatString;
			return dateFormat.format(date);
		}
		
		/*
			Use to move date by num days.
		*/		
		public static function moveDateByDay(date:Date, day:int):Date {
			return new Date(date.setDate(date.date + day));
		}
	}
}