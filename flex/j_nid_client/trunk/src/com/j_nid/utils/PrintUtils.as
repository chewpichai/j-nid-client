package com.j_nid.utils {
	
	import com.j_nid.components.mxml.print.OrderPrintView;
	import com.j_nid.components.mxml.print.TransactionPrintView;
	import com.j_nid.models.Order;
	
	import mx.core.Application;
	import mx.printing.FlexPrintJob;
	
	public class PrintUtils {
		
		public static function printOrder(order:Order):void {
			var printJob:FlexPrintJob = new FlexPrintJob();
			printJob.printAsBitmap = false;
            if (printJob.start()) {
                // Create a FormPrintView control as a child of the current view.
                var thePrintView:OrderPrintView = new OrderPrintView();
				Application.application.addChild(thePrintView);
                //Set the print view properties.
                thePrintView.width = printJob.pageWidth;
                thePrintView.height = printJob.pageHeight;
                thePrintView.order = order;
                // Set the data provider of the FormPrintView component's data grid
                // to be the data provider of the displayed data grid.
                thePrintView.myDataGrid.dataProvider = order.orderItems;
                // Create a single-page image.
                thePrintView.showPage("single");
                // If the print image's data grid can hold all the provider's rows,
                // add the page to the print job.
                if (!thePrintView.myDataGrid.validNextPage) {
                    printJob.addObject(thePrintView);
                } else { // Otherwise, the job requires multiple pages.
                    // Create the first page and add it to the print job.
                    thePrintView.showPage("first");
                    printJob.addObject(thePrintView);
                    thePrintView.pageNumber++;
                    // Loop through the following code until all pages are queued.
                    while (true) {
                        // Move the next page of data to the top of the print grid.
                        thePrintView.myDataGrid.nextPage();
                        thePrintView.showPage("last");
                        // If the page holds the remaining data, or if the last page
                        // was completely filled by the last grid data, queue it for printing.
                        // Test if there is data for another PrintDataGrid page.
                        if (!thePrintView.myDataGrid.validNextPage) {
                            // This is the last page; queue it and exit the print loop.
                            printJob.addObject(thePrintView);
                            break;
                        } else { // This is not the last page. Queue a middle page.
                            thePrintView.showPage("middle");
                            printJob.addObject(thePrintView);
                            thePrintView.pageNumber++;
                        }
                    }
                }
                // All pages are queued; remove the FormPrintView control to free memory.
                Application.application.removeChild(thePrintView);
            }
            // Send the job to the printer.
            printJob.send();
		}
		
		public static function printPayment():void {
			var printJob:FlexPrintJob = new FlexPrintJob();
			printJob.printAsBitmap = false;
            if (printJob.start()) {
                // Create a FormPrintView control as a child of the current view.
                var printView:TransactionPrintView = new TransactionPrintView();
               	Application.application.addChild(printView);
                //Set the print view properties.
                printView.width = printJob.pageWidth;
                printView.height = printJob.pageHeight;
                if (!printView.hasMultiPage()) {
                	printJob.addObject(printView);
                } else {
                	printView.showPage("orderFirst");
                	printJob.addObject(printView);
                	while (printView.orderDG.validNextPage) {
                		printView.orderDG.nextPage();
                		printView.showPage("orderSecond");
                		printJob.addObject(printView);
                	}
                	printView.showPage("paymentFirst");
                	printJob.addObject(printView);
                	while (printView.paymentDG.validNextPage) {
                		printView.paymentDG.nextPage();
                		printView.showPage("paymentSecond");
                		printJob.addObject(printView);
                	}
                }
                // All pages are queued; remove the FormPrintView control to free memory.
                Application.application.removeChild(printView);
            }
            // Send the job to the printer.
            printJob.send();
		}
	}
}