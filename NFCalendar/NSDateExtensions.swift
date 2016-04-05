//
//  NSDateExtensions.swift
//  NFCalendarSample
//
//  Created by Noel Feliciano on 2016-04-04.
//  Copyright © 2016 nfsw. All rights reserved.
//

import Foundation

extension NSDate {
    func numDaysInMonth() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let days = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self)
        return days.length
    }
    
    func numCalendarSlotsInMonth() -> Int {
        return 0
    }
}