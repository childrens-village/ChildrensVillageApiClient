import Foundation

public enum DayOfWeek: String, CaseIterable, Codable, Equatable {
  case Monday
  case Tuesday
  case Wednesday
  case Thursday
  case Friday
  case Saturday
  case Sunday
}

func getDayOfWeek(date: Date) throws -> DayOfWeek {
  let datePart = Calendar.current.dateComponents(in: TimeZone.current, from: date)
  // 1: Sunday, ..., 7: Saturday
  let weekdayIndex = datePart.weekday!

  var dayOfWeekIndex = weekdayIndex - 2
  if (dayOfWeekIndex == -1) {
    dayOfWeekIndex = 6 // Special case for Sunday
  }

  return DayOfWeek.allCases[dayOfWeekIndex]
}
