import Foundation

public struct ParentModel: Attending, Identifiable, Decodable, Sendable {
  public let id: UUID
  public let active: Bool?
  public let facilitating: Bool?
  public let primary: Bool?
  public let firstName: String
  public let lastName: String
  public let prefix: TitlePrefix
  public let phone: String
  public let email: String?
  public let attendances: [AttendanceModel]?
}
