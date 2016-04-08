//
//  DateManagement.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/8/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit

class DateManagement: NSObject {

    class func StringToDate(dateStringFormat:String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.dateFromString(dateStringFormat)
        return date!
    }
    
    class func getMonthWithDate(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.stringFromDate(date)
        let month = self.getMonthAcronym(date)
        return month
    }
    
     class func getDayWithDate(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.stringFromDate(date)
        let day = self.getDay(date)
        return day
    }
    
     class func getMonthAcronym(fecha:String) -> String {
        var dateSplited = fecha.componentsSeparatedByString("-")
        var month:String
        
        switch dateSplited[1] {
        case "01":
            month = "ENE"
            return (month)
        case "02":
            month = "FEB"
            return (month)
        case "03":
            month = "MAR"
            return (month)
        case "04":
            month = "APR"
            return (month)
        case "05":
            month = "MAY"
            return (month)
        case "06":
            month = "JUN"
            return (month)
        case "07":
            month = "JUL"
            return (month)
        case "08":
            month = "AUG"
            return (month)
        case "09":
            month = "SEP"
            return (month)
        case "10":
            month = "OCT"
            return (month)
        case "11":
            month = "NOV"
            return (month)
        case "12":
            month = "DIC"
            return (month)
        default:
            return("")
        }
    }
    
    class func getDay(fecha:String) -> String {
        let date = fecha.stringByReplacingOccurrencesOfString("T", withString: "-")
        var dateSplited = date.componentsSeparatedByString("-")
        let day = dateSplited[2]
        return day
    }

}
