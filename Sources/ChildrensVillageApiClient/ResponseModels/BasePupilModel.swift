import Foundation

public struct BasePupilModel: Person, Decodable {
  public let id: UUID
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix
}
