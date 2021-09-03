import Foundation

public struct Pupil: Decodable {
  let id: String
  let firstName: String
  let lastName: String
  let dateOfBirth: String?
  let prefix: TitlePrefix?
}
