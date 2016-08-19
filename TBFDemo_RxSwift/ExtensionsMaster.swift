//
//  ExtensionsMaster.swift
//  TBFDemo_RxSwift
//
//  Created by khan on 18/08/16.
//  Copyright © 2016 TBF. All rights reserved.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif




struct TupleStruct {
    var value: (String, String)
}

extension TupleStruct {
    func durationOfTransport() -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateFormat = "k:mm"
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone=timeZone
        let startDate = dateFormatter.dateFromString(value.0)
        let endDate = dateFormatter.dateFromString(value.1)
        let (h,m) =  hoursBetweenDates(startDate!, endDate: endDate!)
        return "\(h):\(m)h"
    }
    
    func hoursBetweenDates(startDate: NSDate, endDate: NSDate) -> (Int,Int) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour,.Minute], fromDate: startDate, toDate: endDate, options: [])
        return (components.hour,components.minute)
    }
}

extension String {
    func addingLeadingZeros() -> String {
        if Int(self) < 10 {
            return String(format: "%02d", Int(self)!) }
        else { return self }
    }

}

private typealias NoStopsExtension = Int

extension NoStopsExtension {
    func zeroOrMore() -> String {
        if self == 0 {
            return "   Direct"
        } else { return "   No. of stops \(self)"}
    }
}

extension Double {
    func formatAsCurrency(currencyCode: String) -> String {
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
        return currencyFormatter.stringFromNumber(self)!
    }
}