import Foundation

public struct Pupil: Identifiable, Decodable {
  public let id: String
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix?
}
