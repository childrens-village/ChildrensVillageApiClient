//
//  getDayOfWeekByIndex.swift
//  getDayOfWeekByIndex
//
//  Created by Chris Kobrzak on 18/08/2021.
//

import Foundation

func getDayOfWeekByIndex(_ dayOfWeekIndex: Int) -> String {
  var dayOfWeek: String

  if dayOfWeekDictionary.keys.contains(dayOfWeekIndex) {
    dayOfWeek = dayOfWeekDictionary[dayOfWeekIndex]!
  } else {
    // Consider a helper that can work out today's index
    dayOfWeek = dayOfWeekDictionary[1]!
  }

  return dayOfWeek
}
