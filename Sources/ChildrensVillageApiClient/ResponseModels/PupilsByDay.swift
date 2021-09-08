import Foundation

public struct PupilsByDay: Decodable {
  public let id: Int
  public let day: DayOfWeek
  public let pupils: [Pupil]
}
