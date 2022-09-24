import Foundation

public struct DayOfWeekModel: Decodable {
  public let id: Int
  public let day: DayOfWeek
  public let pupils: [PupilModel]?
}
