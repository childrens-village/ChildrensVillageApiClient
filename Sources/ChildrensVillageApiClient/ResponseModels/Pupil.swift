import Foundation

public struct Pupil: Attending, Identifiable, Decodable {
  public let id: UUID
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix
  // TODO: The new fields need to be decoded!
  public let parents: [Parent]?
  public let attendances: [Attendance]?
  public let branches: [Branch]?
  public let daysOfWeek: [DayOfWeekModel]?
}
