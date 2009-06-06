package com.j_nid.utils {
	
	import com.j_nid.components.mxml.prints.OrderPrintView;
	import com.j_nid.components.mxml.prints.OutstandingPrintView;
	import com.j_nid.components.mxml.prints.PaymentsPrintView;
	import com.j_nid.models.Order;
	import com.j_nid.models.Person;
	
	import mx.core.Application;
	import mx.printing.FlexPrintJob;
	
	public class PrintUtils {
		
		public static function printOrder(order:Order):void {
			var printJob:FlexPrintJob = new FlexPrintJob();
			printJob.printAsBitmap = false;
            if (printJob.start()) {
                // Create a FormPrintView control as a child of the current view.
                var printView:OrderPrintView = new OrderPrintView();
				Application.application.addChild(printView);
                //Set the print view properties.
                printView.width = printJob.pageWidth;
                printView.height = printJob.pageHeight;
                printView.order = order;
                // Create a single-page image.
                printView.showPage("single");
                // If the print image's data grid can hold all the provider's rows,
                // add the page to the print job.
                if (!printView.orderItemList.validNextPage) {
                    printJob.addObject(printView);
                } else { // Otherwise, the job requires multiple pages.
                    // Create the first page and add it to the print job.
                    printView.showPage("first");
                    printJob.addObject(printView);
                    printView.pageNumber++;
                    // Loop through the following code until all pages are queued.
                    while (true) {
                        // Move the next page of data to the top of the print grid.
                        printView.orderItemList.nextPage();
                        printView.showPage("last");
                        // If the page holds the remaining data, or if the last page
                        // was completely filled by the last grid data, queue it for printing.
                        // Test if there is data for another PrintDataGrid page.
                        if (!printView.orderItemList.validNextPage) {
                            // This is the last page; queue it and exit the print loop.
                            printJob.addObject(printView);
                            break;
                        } else { // This is not the last page. Queue a middle page.
                            printView.showPage("middle");
                            printJob.addObject(printView);
                            printView.pageNumber++;
                        }
                    }
                }
                // All pages are queued remove the FormPrintView control to free memory.
                Application.application.removeChild(printView);
            }
            // Send the job to the printer.
            printJob.send();
		}
		
		public static function printTransaction(person:Person,
		                                        startDate:Date,
		                                        endDate:Date):void {
			
			var printJob:FlexPrintJob = new FlexPrintJob();
            printJob.printAsBitmap = false;
            if (printJob.start()) {
            	var outstandingPrintView:OutstandingPrintView = 
                        new OutstandingPrintView();
            	Application.application.addChild(outstandingPrintView);
                //Set the print view properties.
            	outstandingPrintView.startDate = startDate;
            	outstandingPrintView.endDate = endDate;
            	outstandingPrintView.person = person;
                outstandingPrintView.width = printJob.pageWidth;
                outstandingPrintView.height = printJob.pageHeight;
                // Set the data provider of the FormPrintView component's data grid
                // to be the data provider of the displayed data grid.
                outstandingPrintView.orderList.dataProvider = person.orders;
                // Create a single-page image.
                outstandingPrintView.showPage("single");
                // If the print image's data grid can hold all the provider's rows,
                // add the page to the print job.
                if (!outstandingPrintView.orderList.validNextPage) {
                    printJob.addObject(outstandingPrintView);
                } else { // Otherwise, the job requires multiple pages.
                    // Create the first page and add it to the print job.
                    outstandingPrintView.showPage("first");
                    printJob.addObject(outstandingPrintView);
                    // Loop through the following code until all pages are queued.
                    while (true) {
                        // Move the next page of data to the top of the print grid.
                        outstandingPrintView.orderList.nextPage();
                        outstandingPrintView.showPage("last");
                        // If the page holds the remaining data, or if the last page
                        // was completely filled by the last grid data, queue it for printing.
                        // Test if there is data for another PrintDataGrid page.
                        if (!outstandingPrintView.orderList.validNextPage) {
                            // This is the last page; queue it and exit the print loop.
                            printJob.addObject(outstandingPrintView);
                            break;
                        } else { // This is not the last page. Queue a middle page.
                            outstandingPrintView.showPage("middle");
                            printJob.addObject(outstandingPrintView);
                        }
                    }
                }
                // All pages are queued remove the FormPrintView control to free memory.
                Application.application.removeChild(outstandingPrintView);
                // Print paymnets.
                var paymentPrintView:PaymentsPrintView = 
                           new PaymentsPrintView();
                Application.application.addChild(paymentPrintView);
                //Set the print view properties.
                paymentPrintView.startDate = startDate;
                paymentPrintView.endDate = endDate;
                paymentPrintView.person = person;
                paymentPrintView.width = printJob.pageWidth;
                paymentPrintView.height = printJob.pageHeight;
                // Set the data provider of the FormPrintView component's data grid
                // to be the data provider of the displayed data grid.
                paymentPrintView.paymentList.dataProvider = person.payments;
                // Create a single-page image.
                paymentPrintView.showPage("single");
                // If the print image's data grid can hold all the provider's rows,
                // add the page to the print job.
                if (!paymentPrintView.paymentList.validNextPage) {
                    printJob.addObject(paymentPrintView);
                } else { // Otherwise, the job requires multiple pages.
                    // Create the first page and add it to the print job.
                    paymentPrintView.showPage("first");
                    printJob.addObject(paymentPrintView);
                    // Loop through the following code until all pages are queued.
                    while (true) {
                        // Move the next page of data to the top of the print grid.
                        paymentPrintView.paymentList.nextPage();
                        paymentPrintView.showPage("last");
                        // If the page holds the remaining data, or if the last page
                        // was completely filled by the last grid data, queue it for printing.
                        // Test if there is data for another PrintDataGrid page.
                        if (!paymentPrintView.paymentList.validNextPage) {
                            // This is the last page; queue it and exit the print loop.
                            printJob.addObject(paymentPrintView);
                            break;
                        } else { // This is not the last page. Queue a middle page.
                            outstandingPrintView.showPage("middle");
                            printJob.addObject(paymentPrintView);
                        }
                    }
                }
                // All pages are queued remove the FormPrintView control to free memory.
                Application.application.removeChild(paymentPrintView);
            }
            printJob.send();
		}
	}
}