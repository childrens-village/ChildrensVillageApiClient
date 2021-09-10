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

func getDayOfWeek(string: String) throws -> DayOfWeek {
  for dayOfWeek in DayOfWeek.allCases {
    if (dayOfWeek.rawValue != string) {
      continue
    }

    return dayOfWeek
  }

  throw InputError.unknownDayOfWeek
}
