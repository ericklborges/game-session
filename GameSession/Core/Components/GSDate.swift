//
//  GSDate.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 22/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation

public struct GSDate {
    public let rawValue: Date
    public let calendar: Calendar
    public let timeZone: TimeZone

    public init(
        _ date: Date = Date(),
        timeZone: TimeZone = .current,
        calendar: Calendar = .current

    ) {
        self.rawValue = date
        self.timeZone = timeZone
        self.calendar = calendar
    }

    public init?(
        day: Int,
        month: Int,
        year: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        timeZone: TimeZone = .current,
        calendar: Calendar = .current
    ) {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        dateComponents.timeZone = timeZone
        dateComponents.calendar = calendar

        guard let date = dateComponents.date else { return nil }
        self.init(date, timeZone: timeZone, calendar: calendar)
    }
}

// MARK: - Equatable

extension GSDate: Equatable {
    public static func == (_ lhs: GSDate, _ rhs: GSDate) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    public static func != (_ lhs: GSDate, _ rhs: GSDate) -> Bool {
        lhs.rawValue != rhs.rawValue
    }
}

// MARK: - Comparable

extension GSDate: Comparable {
    public static func > (lhs: GSDate, rhs: GSDate) -> Bool {
        lhs.rawValue > rhs.rawValue
    }
    
    public static func < (lhs: GSDate, rhs: GSDate) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Values

extension GSDate {
    public static var today: GSDate { .init(Date()) }
    public static var tomorrow: GSDate { today.add(1, to: .day) }
    public static var yesterday: GSDate { today.add(-1, to: .day) }
}

// MARK: - Comparations

extension GSDate {
    public func isSameDayMonthYear(as otherDate: GSDate) -> Bool {
        isSameDate(as: otherDate, comparing: [.day, .month, .year])
    }

    public func isSameDate(
        as otherDate: GSDate,
        comparing components: [Calendar.Component] = [.day, .month, .year, .hour, .minute, .second]
    ) -> Bool {
        let equalComponents = components
            .filter { calendar.isDate(rawValue, equalTo: otherDate.rawValue, toGranularity: $0) }
        return components.count == equalComponents.count
    }
}

// MARK: - Modifiers

extension GSDate {
    public func add(_ value: Int, to component: Calendar.Component) -> GSDate {
        guard let modifiedDate = calendar.date(byAdding: component, value: value, to: rawValue) else { return self }
        return GSDate(modifiedDate)
    }
}

// MARK: - Formatting

extension GSDate {
    public func formatted(date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle) -> String {
        rawValue.formatted(date: date, time: time)
    }
}
