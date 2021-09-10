//
//  getLocalDateParts.swift
//
//  Created by Chris Kobrzak on 10/09/2021.
//

import Foundation

func getLocalDateParts(_ from: Date = Date()) -> (String, DayOfWeek) {
  let formatter = DateFormatter()
  formatter.timeZone = TimeZone.current
  formatter.calendar = Calendar(identifier: .iso8601)

  formatter.dateFormat = "yyyy-MM-dd"
  let isoDate = formatter.string(from: from)

  formatter.dateFormat = "EEEE"
  let dayOfWeekString = formatter.string(from: from)
  let dayOfWeek = try! getDayOfWeek(string: dayOfWeekString)

  return (isoDate, dayOfWeek)
}
