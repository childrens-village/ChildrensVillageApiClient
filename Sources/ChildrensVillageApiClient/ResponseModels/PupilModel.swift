import Foundation

public struct PupilModel: Attending, Identifiable, Decodable {
  public let id: UUID
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix
  public let parents: [Parent]?
  public let attendances: [AttendanceModel]?
  public let branches: [BranchModel]?
  public let daysOfWeek: [DayOfWeekModel]?
}
