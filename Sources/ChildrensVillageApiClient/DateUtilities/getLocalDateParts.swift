//
//  getLocalDateParts.swift
//
//  Created by Chris Kobrzak on 10/09/2021.
//

import Foundation

func getLocalIsoTimeParts(_ from: Date = Date()) -> (String, String) {
  let formatter = DateFormatter()
  formatter.timeZone = TimeZone.current
  formatter.calendar = Calendar(identifier: .iso8601)

  formatter.dateFormat = "yyyy-MM-dd"
  let isoDate = formatter.string(from: from)

  formatter.dateFormat = "HH:mm"
  let isoTime = formatter.string(from: from)

  return (isoDate, isoTime)
}
