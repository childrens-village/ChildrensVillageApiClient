import Foundation

// TODO: These non-response models should have the Model suffix from now on
public struct DayOfWeekModel: Decodable {
  public let id: Int
  public let day: DayOfWeek
  public let pupils: [PupilModel]?
}
