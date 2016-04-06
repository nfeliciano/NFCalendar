//
//  NSDateExtensions.swift
//  NFCalendarSample
//
//  Created by Noel Feliciano on 2016-04-04.
//  Copyright © 2016 nfsw. All rights reserved.
//

import Foundation

extension NSDate {
    
    convenience init( year:Int, month:Int, day:Int) {
        let calendar = NSCalendar.currentCalendar()
        let dateComponent = NSDateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        self.init(timeInterval:0, sinceDate:calendar.dateFromComponents(dateComponent)!)
    }
    
    // Get the number of days for the month
    func numDaysInMonth() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let days = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self)
        return days.length
    }
    
    func firstDayOfMonth () -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let dateComponent = calendar.components([.Year, .Month, .Day ], fromDate: self)
        dateComponent.day = 1
        return calendar.dateFromComponents(dateComponent)!
    }
    
    func numCalendarSlotsInMonth() -> Int {
        print("\(firstDayOfMonth().whichMonth())")
        return numDaysInMonth() + firstDayOfMonth().whichWeekday() - 1
    }
    
    func whichYear() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let dateComponent = calendar.components(.Year, fromDate: self)
        return dateComponent.year
    }
    
    func whichMonth() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let dateComponent = calendar.components(.Month, fromDate: self)
        return dateComponent.month
    }
    
    func whichDay() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let dateComponent = calendar.components(.Day, fromDate: self)
        return dateComponent.day
    }
    
    // Returns an int of which day of the week it is, 1 for Sunday
    func whichWeekday() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let dateComponent = calendar.components(.Weekday, fromDate: self)
        return dateComponent.weekday
    }
    
    func weekdayNameFromDay( dayOfWeek:Int ) -> String {
        switch (dayOfWeek) {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                return "Noday"
        }
    }
    
    func weekdayName( date:NSDate ) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayName:String = dateFormatter.stringFromDate(date)
        return dayName
    }
}