package com.j_nid.utils {
	
	import com.j_nid.ui.prints.OrderPrintView;
	import com.j_nid.ui.prints.OutstandingPrintView;
	import com.j_nid.ui.prints.PaymentPrintView;
	
	import mx.collections.ListCollectionView;
	import mx.collections.XMLListCollection;
	import mx.core.Application;
	import mx.printing.FlexPrintJob;
	
	public class PrintUtils {
		
		private static const NUM_ITEMS_PER_PAGE:int = 14;
		
		public static function printOrder(order:XML):void {
			var printJob:FlexPrintJob = new FlexPrintJob();
			printJob.printAsBitmap = false;
            if (printJob.start()) {
                // Create a print view control as a child of the current view.
                var printView:OrderPrintView = new OrderPrintView();
				Application.application.addChild(printView);
                //Set the print view properties.
                printView.width = printJob.pageWidth;
                printView.height = printJob.pageHeight;
                printView.order = order;
				var orderItems:Array = new XMLListCollection(order.order_items.children()).toArray();
                var numOrderItems:int = orderItems.length;
                var numPages:int = Math.ceil(numOrderItems / NUM_ITEMS_PER_PAGE);
                if (numPages > 1) {
                	var pageNum:int = 1;
                	printView.numPages = numPages;
                	while(true) {
                		var start:int = (pageNum - 1) * NUM_ITEMS_PER_PAGE;
                        var end:int = pageNum * NUM_ITEMS_PER_PAGE;
                		printView.orderItems = orderItems.slice(start, end);
                		printView.pageNum = pageNum;
                		if (pageNum == numPages) {
                            printView.currentState = null;
                            printJob.addObject(printView);
                            break;
                		} else {
                			printView.currentState = "middle";
                            printJob.addObject(printView);
                		}
                		pageNum++;
                	}
                } else {
                	printView.orderItems = orderItems;
                	printView.numPages = 1;
                	printView.pageNum = 1;
                	printJob.addObject(printView);
                }
                // All pages are queued remove the print view control to free memory.
                Application.application.removeChild(printView);
            }
            // Send the job to the printer.
            printJob.send();
		}
		
		public static function printTransaction(person:XML, transactions:ListCollectionView,
									startDate:Date, endDate:Date):void {
			
			var printJob:FlexPrintJob = new FlexPrintJob();
            printJob.printAsBitmap = false;
            if (printJob.start()) {
            	var outstandingPrintView:OutstandingPrintView = 
                        new OutstandingPrintView();
            	Application.application.addChild(outstandingPrintView);
                //Set the print view properties.
            	outstandingPrintView.startDate = startDate;
            	outstandingPrintView.endDate = endDate;
            	outstandingPrintView.personName = person.name;
                outstandingPrintView.width = printJob.pageWidth;
                outstandingPrintView.height = printJob.pageHeight;
                var balance:Number = getBalance(transactions);
                var outstandingOrders:Array = getOutstandingOrders(transactions);
                if (balance < 0) {
                	outstandingOrders.unshift({created: "ยอดค้างยกมา",
						outstanding: Math.abs(balance)});
                }
                var numOrders:int = outstandingOrders.length;
                var numPages:int = Math.ceil(numOrders / NUM_ITEMS_PER_PAGE);
                if (numPages > 1) {
                    var pageNum:int = 1;
                    outstandingPrintView.numPages = numPages;
                    while(true) {
                        var start:int = (pageNum - 1) * NUM_ITEMS_PER_PAGE;
                        var end:int = pageNum * NUM_ITEMS_PER_PAGE;
                        outstandingPrintView.orders = outstandingOrders.slice(start, end);
                        outstandingPrintView.pageNum = pageNum;
                        if (pageNum == numPages) {
                            outstandingPrintView.currentState = null;
                            printJob.addObject(outstandingPrintView);
                            break;
                        } else {
                            outstandingPrintView.currentState = "middle";
                            printJob.addObject(outstandingPrintView);
                        }
                        pageNum++;
                    }
                } else {
                	outstandingPrintView.orders = outstandingOrders;
                	outstandingPrintView.numPages = 1;
                    outstandingPrintView.pageNum = 1;
                    printJob.addObject(outstandingPrintView);
                }
                // All pages are queued remove the print view control to free memory.
                Application.application.removeChild(outstandingPrintView);
                // Print paymnets.
                var paymentPrintView:PaymentPrintView = 
                           new PaymentPrintView();
                Application.application.addChild(paymentPrintView);
                //Set the print view properties.
                paymentPrintView.startDate = startDate;
                paymentPrintView.endDate = endDate;
                paymentPrintView.personName = person.name;
                paymentPrintView.width = printJob.pageWidth;
                paymentPrintView.height = printJob.pageHeight;
                var payments:Array = getPayments(transactions);
                if (balance > 0) {
                    payments.unshift({created: "ยอดจ่ายยกมา",
                       paid: Math.abs(balance)});
                }
                paymentPrintView.outstandingSummary = 
                    Utils.sum(outstandingOrders, "outstanding") - Utils.sum(payments, "paid");
                numOrders = payments.length;
                numPages = Math.ceil(numOrders / NUM_ITEMS_PER_PAGE);
                if (numPages > 1) {
                    pageNum = 1;
                    paymentPrintView.numPages = numPages;
                    while(true) {
                        start = (pageNum - 1) * NUM_ITEMS_PER_PAGE;
                        end = pageNum * NUM_ITEMS_PER_PAGE;
                        paymentPrintView.payments = payments.slice(start, end);
                        paymentPrintView.pageNum = pageNum;
                        if (pageNum == numPages) {
                            paymentPrintView.currentState = null;
                            printJob.addObject(paymentPrintView);
                            break;
                        } else {
                            paymentPrintView.currentState = "middle";
                            printJob.addObject(paymentPrintView);
                        }
                        pageNum++;
                    }
                } else {
                    paymentPrintView.payments = payments;
                    paymentPrintView.numPages = 1;
                    paymentPrintView.pageNum = 1;
                    printJob.addObject(paymentPrintView);
                }
                // All pages are queued remove the FormPrintView control to free memory.
                Application.application.removeChild(paymentPrintView);
            }
            // Send the job to the printer.
            printJob.send();
		}
		
		private static function getBalance(transactions:ListCollectionView):Number {
			var transaction:XML = XML(transactions.getItemAt(transactions.length - 1));
			if (transaction.type == "balance")
				return Number(transaction.balance);
			return 0;
		}
		
		private static function getOutstandingOrders(transactions:ListCollectionView):Array {
			var orders:Array = new Array();
            for each (var transaction:XML in transactions) {
                if (transaction.type == "order")
					orders.push(transaction);
            }
            return orders;
		}
		
		public static function getPayments(transactions:ListCollectionView):Array {
            var payments:Array = new Array();
			for each (var transaction:XML in transactions) {
				if (transaction.type == "payment")
					payments.push(transaction);
			}
            return payments;
        }
	}
}