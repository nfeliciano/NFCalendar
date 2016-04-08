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
    
    // Returns the number of cells the calendar month needs
    // In the very special case of non-leap Feburary (where the 1st is a Sunday), return 28
    // Otherwise, return 35 or 42 depending on how the days fall in the calendar
    func numCalendarSlotsInMonth() -> Int {
        let previous:Int = firstDayOfMonth().whichWeekday()-1
        let current:Int = numDaysInMonth()
        if (current + previous <= 28) {
            return 28
        }
        else {
            return (previous + current <= 35 ? 35 : 42)
        }
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
    
    func monthName( abbrev:Bool ) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = abbrev ? "MMM" : "MMMM"
        let monthName:String = dateFormatter.stringFromDate(self)
        return monthName
    }
    
    // Not sure if we need this
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
    
    func weekdayName( abbrev:Bool ) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = abbrev ? "EEE" : "EEEE"
        let dayName:String = dateFormatter.stringFromDate(self)
        return dayName
    }
}