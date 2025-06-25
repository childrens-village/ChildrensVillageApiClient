import Foundation

public struct PupilSummaryModel: Person, Decodable {
  public let id: UUID
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix

  // Additional properties
  public let active: Bool
}
