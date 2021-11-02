import Foundation

public struct Pupil: Attending, Identifiable, Decodable {
  public let id: String
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix
  public let attendances: [Attendance]?
}
