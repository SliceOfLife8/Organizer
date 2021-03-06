//
//  Date+Extensions.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 23/2/22.
//

import Foundation

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayAfterThreeDays: Date {
        return Calendar.current.date(byAdding: .day, value: 3, to: self)!
    }

    var dayAfterWeek: Date {
        return Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: self)!
    }

    var dayAfterMonth: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }

    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
}
