import Foundation

public struct PupilModel: Person, Attending, Decodable, Sendable {
  public let id: UUID
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix
  public let activeUntil: String?
  public let photographyConsent: Bool?
  public let allergies: String?
  public let parents: [ParentModel]?
  public let attendances: [AttendanceModel]?
  public let branches: [BranchModel]?
  public let daysOfWeek: [DayOfWeekModel]?
}
