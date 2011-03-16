package com.j_nid.utils {
    
    import com.j_nid.ui.prints.MonthlyReportPrintView;
    import com.j_nid.ui.prints.OrderPrintView;
    import com.j_nid.ui.prints.ReportPrintView;
    import com.j_nid.ui.prints.ReportSummaryPrintView;
    import com.j_nid.ui.prints.TransactionPrintView;
    
    import mx.collections.ArrayCollection;
    import mx.collections.ArrayList;
    import mx.collections.ListCollectionView;
    import mx.collections.XMLListCollection;
    import mx.core.Application;
    import mx.core.FlexGlobals;
    import mx.printing.FlexPrintJob;
    import mx.printing.FlexPrintJobScaleType;
    
    public class PrintUtils {
        
        private static const NUM_ITEMS_PER_PAGE:int = 14;
        private static const NUM_TRANSACTIONS_PER_PAGE:int = 30;
        
        public static function printOrder(order:XML):void
        {
            var printJob:FlexPrintJob = new FlexPrintJob();
            printJob.printAsBitmap = false;
            if (printJob.start())
            {
                // Create a print view control as a child of the current view.
                var printView:OrderPrintView = new OrderPrintView();
                FlexGlobals.topLevelApplication.addElement(printView);
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
                            printView.currentState = "base";
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
                // Send the job to the printer.
                printJob.send();
                // All pages are queued remove the print view control to free memory.
                FlexGlobals.topLevelApplication.removeElement(printView);
            }
        }
        
        public static function printTransaction(person:XML, transactions:ListCollectionView,
                                                startDate:Date, endDate:Date):void
        {   
            var printJob:FlexPrintJob = new FlexPrintJob();
            printJob.printAsBitmap = false;
            if (printJob.start()) {
                var transactionPrintView:TransactionPrintView = 
                    new TransactionPrintView();
                FlexGlobals.topLevelApplication.addElement(transactionPrintView);
                //Set the print view properties.
                transactionPrintView.width = printJob.pageWidth;
                transactionPrintView.height = printJob.pageHeight;
                transactionPrintView.startDate = startDate;
                transactionPrintView.endDate = endDate;
                transactionPrintView.personName = person.name;
                var balance:Number = getBalance(transactions);
                var outstandingOrders:Array = getOutstandingOrders(transactions);
                if (balance < 0) {
                    outstandingOrders.unshift({created: "ยอดค้างยกมา",
                        outstanding: Math.abs(balance)});
                }
                transactionPrintView.outstandingTotal = Utils.sum(outstandingOrders, "outstanding");
                transactionPrintView.orders = outstandingOrders;
                var payments:Array = getPayments(transactions);
                if (balance > 0) {
                    payments.unshift({created: "ยอดจ่ายยกมา",
                        paid: Math.abs(balance)});
                }
                transactionPrintView.paidTotal = Utils.sum(payments, "paid");
                transactionPrintView.payments = payments;
                transactionPrintView.startJob();
                do
                {
                    printJob.addObject(transactionPrintView);
                }
                while (transactionPrintView.nextPage());
                printJob.addObject(transactionPrintView);
                // Send the job to the printer.
                printJob.send();
                // All pages are queued remove the print view control to free memory.
                FlexGlobals.topLevelApplication.removeElement(transactionPrintView);
            }
        }
        
        public static function printReport(transactions:Array,
                                           customerName:String, startDate:Date,
                                           endDate:Date, quantitySum:String,
                                           orderSum:String, paymentSum:String):void
        {
            var printJob:FlexPrintJob = new FlexPrintJob();
            printJob.printAsBitmap = false;
            if (printJob.start())
            {
                var reportPrintView:ReportPrintView = new ReportPrintView();
                FlexGlobals.topLevelApplication.addElement(reportPrintView);
                reportPrintView.width = printJob.pageWidth;
                reportPrintView.height = printJob.pageHeight;
                reportPrintView.customerName = customerName;
                reportPrintView.startDate = startDate;
                reportPrintView.endDate = endDate;
                reportPrintView.quantitySum = quantitySum;
                reportPrintView.orderSum = orderSum;
                reportPrintView.paymentSum = paymentSum;
                transactions.sort(function(a:*, b:*):Number {
                    var aDate:Date = new Date(Date.parse(a.created));
                    var bDate:Date = new Date(Date.parse(b.created));
                    if (aDate > bDate)
                        return 1;
                    else if (aDate < bDate)
                        return -1;
                    return 0;
                });
                reportPrintView.transactions = new ArrayList(transactions);
                reportPrintView.startJob();
                do
                {
                    printJob.addObject(reportPrintView);
                }
                while (reportPrintView.nextPage());
                printJob.addObject(reportPrintView);
                printJob.send();
                FlexGlobals.topLevelApplication.removeElement(reportPrintView);
            }
        }
        
        public static function printReportSummary(people:Array,
                                                  startDate:Date,
                                                  endDate:Date,
                                                  showQuantity:Boolean,
                                                  showOrderedTotal:Boolean,
                                                  showPaid:Boolean,
                                                  showOutstandingTotal:Boolean):void
        {
            var printJob:FlexPrintJob = new FlexPrintJob();
            printJob.printAsBitmap = false;
            if (printJob.start())
            {
                var reportPrintView:ReportSummaryPrintView = new ReportSummaryPrintView();
                FlexGlobals.topLevelApplication.addElement(reportPrintView);
                reportPrintView.width = printJob.pageWidth;
                reportPrintView.height = printJob.pageHeight;
                reportPrintView.people = new ArrayList(people);
                reportPrintView.startDate = startDate;
                reportPrintView.endDate = endDate;
                reportPrintView.showQuantity = showQuantity;
                reportPrintView.showOrderedTotal = showOrderedTotal;
                reportPrintView.showPaid = showPaid;
                reportPrintView.showOutstandingTotal = showOutstandingTotal;
                reportPrintView.startJob();
                do
                {
                    printJob.addObject(reportPrintView);
                }
                while (reportPrintView.nextPage());
                printJob.addObject(reportPrintView);
                printJob.send();
                FlexGlobals.topLevelApplication.removeElement(reportPrintView);
            }
        }
        
        public static function printMonthlyReport(transactions:Array,
                                                  year:int, month:int):void
        {
            var printJob:FlexPrintJob = new FlexPrintJob();
            printJob.printAsBitmap = false;
            if (printJob.start())
            {
                var printView:MonthlyReportPrintView = new MonthlyReportPrintView();
                FlexGlobals.topLevelApplication.addElement(printView);
                printView.width = printJob.pageWidth;
                printView.height = printJob.pageHeight;
                printView.transactions = new ArrayList(transactions);
                printView.year = year;
                printView.month = month;
                printView.startJob();
                do
                {
                    printJob.addObject(printView);
                }
                while (printView.nextPage());
                //printJob.addObject(printView);
                printJob.send();
                FlexGlobals.topLevelApplication.removeElement(printView);
            }
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
            orders.sort(createdCompare);
            return orders;
        }
        
        public static function getPayments(transactions:ListCollectionView):Array {
            var payments:Array = new Array();
            for each (var transaction:XML in transactions) {
                if (transaction.type == "payment")
                    payments.push(transaction);
            }
            payments.sort(createdCompare);
            return payments;
        }
        
        private static function createdCompare(obj1:Object, obj2:Object):int {
            var date1:Date = new Date(Date.parse(obj1["created"]));
            var date2:Date = new Date(Date.parse(obj2["created"]));
            if (date1 < date2)
                return -1;
            else if (date1 > date2)
                return 1;
            return 0;
        }
    }
}