//
//  Date+extensions.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 17/04/2021.
//

import Foundation

extension Date {
    var asNSDate: NSDate { self as NSDate }

    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        date1.compare(self) == self.compare(date2)
    }
}
