package com.j_nid.utils {
	
	import com.j_nid.ui.AccountPage;
	import com.j_nid.ui.MainPage;
	import com.j_nid.ui.MakeOrderPage;
	import com.j_nid.ui.OrderPage;
	import com.j_nid.ui.PersonPage;
	import com.j_nid.ui.ProductPage;
	import com.j_nid.ui.ReportPage;
	import com.j_nid.ui.popups.Loading;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	import mx.managers.PopUpManager;
	
	[Bindable]
	public class Utils {
		
		private static var instance:Utils;
		private static var dateFormatter:DateFormatter;
		private static var numberFormatter:NumberFormatter;
		private static var loadingCanvasList:Array = [];
		
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
		
		public static function priceLabelFunction(item:Object,
									column:DataGridColumn):String {
		                                          	
            return Utils.formatPrice(item[column.dataField]);
		}
		
		public static function formatPrice(num:Number):String {
		    /*if (numberFormatter == null) {
		        numberFormatter = new NumberFormatter();
		    }
			numberFormatter.precision = 2;
			return numberFormatter.format(num);*/
            return formatUnit(num);
		}
        
        public static function unitLabelFunction(item:Object,
                                    column:DataGridColumn):String {
            
            return Utils.formatUnit(item[column.dataField]);			
        }
        
        public static function formatUnit(num:Number):String {
            if (numberFormatter == null)
                numberFormatter = new NumberFormatter();
            if (num % 1 == 0)
                numberFormatter.precision = 0;
            else
                numberFormatter.precision = 2;
            return numberFormatter.format(num);
        }
		
		public static function sum(obj:Object, field:String):Number {
			var sum:Number = 0;
			for each (var item:* in obj) {
                sum += Number(item[field]);
            }
			return sum;
		}
		
		public static function convertFirstChar(str:String,
		                                        isLower:Boolean):String {

		    var firstChar:String = str.charAt(0);
		    if (isLower) {
		        firstChar = firstChar.toLowerCase();
		    } else {
		        firstChar = firstChar.toUpperCase();
		    }
		    str = firstChar + str.slice(1);
		    return str;
		}
		
		public static function isSameDate(date1:Date, date2:Date):Boolean {
			return date1.date == date2.date && 
			       date1.month == date2.month &&
			       date1.fullYear == date2.fullYear;
		}
		
		public static function getDateStr(date:Date):String {
			return formatDate(date, "YYYY-MM-DD HH");
		}
		
		public static function getDate(date:Date):Date {
            return new Date(date.fullYear, date.month, date.date, date.hours);
        }
        
        public static function showPopUp(className:Class):IFlexDisplayObject {
        	var app:JNid = JNid(Application.application);
            var ui:IFlexDisplayObject = PopUpManager.createPopUp(app,
                                            className, true);
            PopUpManager.centerPopUp(ui);
            return ui;
        }
        
        public static function hidePopUp(popup:IFlexDisplayObject):void {
            PopUpManager.removePopUp(popup);
        }
        
        public static function showLoading():void {
        	loadingCanvasList.push(showPopUp(Loading));
        }
        
        public static function hideLoading():void {
            PopUpManager.removePopUp(loadingCanvasList.pop());
        }
        
        public static function showMainPage():void {
			addToMainContainer(new MainPage());
        }
        
        public static function showMakeOrderPage():void {
			addToMainContainer(new MakeOrderPage());
        }
		
		public static function showProductPage():void {
			addToMainContainer(new ProductPage());
		}
		
		public static function showPersonPage():void {
			addToMainContainer(new PersonPage());
		}
		
		public static function showOrderPage():void {
			addToMainContainer(new OrderPage());
		}
		
		public static function showAccountPage():void {
			addToMainContainer(new AccountPage());
		}
        
        public static function showReportPage():void {
            addToMainContainer(new ReportPage());
        }
		
		public static function addToMainContainer(displayObj:DisplayObject):void {
			clearMainContainer();
			var app:JNid = JNid(Application.application);
			app.mainContainer.addChild(displayObj);
		} 
        
        public static function clearMainContainer():void {
        	var app:JNid = JNid(Application.application);
        	for each (var obj:DisplayObject in app.mainContainer.getChildren())
        	   app.mainContainer.removeChild(obj);
        }
        
        public static function showConfirm(msg:String, title:String,
                                           closeHandler:Function):void {
            
            Alert.show(msg, title, (Alert.OK | Alert.CANCEL), null,
                closeHandler);
        }
        
        public static function getAllProductType():XML {
        	var all:XML = <product_type/>;
            all.id = 0;
            all.name = "ทุกชนิด";
            all.color = 0;
            return all;
        }
        
        public static function getBasketType():XML {
            var basket:XML = <product_type/>;
            basket.id = -1;
            basket.name = "ลังมัดจำ";
            basket.color = 0;
            return basket;
        }
        
        public static function showMessage(msg:String, title:String=""):void {
            Alert.show(msg, title);
        }
		
		public static function escapeRegexChars(s:String):String {
			var escaped:String = 
				s.replace(
					new RegExp("([{}\(\)\^$&.\*\?\/\+\|\[\\\\]|\]|\-)","g"),
					"\\$1");
			return escaped;
		}
	}
}