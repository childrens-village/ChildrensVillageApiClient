import Foundation

public typealias FacilitatorResponse = Parent

extension FacilitatorResponse {
  enum CodingKeys: CodingKey {
    case id
    case firstName
    case lastName
    case prefix
    case phone
    case email
    case attendances
  }

  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
        let id = try? container.decode(UUID.self, forKey: .id),
        let firstName = try? container.decode(String.self, forKey: .firstName),
        let lastName = try? container.decode(String.self, forKey: .lastName),
        let prefix = try? container.decode(TitlePrefix.self, forKey: .prefix),
        let phone = try? container.decode(String.self, forKey: .phone)
    else {
      throw try ErrorResponse(from: decoder).error
    }

    // Handle properties that can have null values or might be missing
    let email = try container.decodeIfPresent(String.self, forKey: .email)
    let attendances = try container.decodeIfPresent([Attendance].self, forKey: .attendances)

    self.init(
      id: id,
      active: nil,
      facilitating: nil,
      primary: nil,
      firstName: firstName,
      lastName: lastName,
      prefix: prefix,
      phone: phone,
      email: email,
      attendances: attendances
    )
  }
}
