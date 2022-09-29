import Foundation

extension ParentModel {
  enum CodingKeys: CodingKey {
    case id
    case active
    case primary
    case facilitating
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
      throw try ErrorModel(from: decoder).error
    }

    // Handle properties that can have null values or might be missing
    let active = try container.decodeIfPresent(Bool.self, forKey: .active)
    let primary = try container.decodeIfPresent(Bool.self, forKey: .primary)
    let facilitating = try container.decodeIfPresent(Bool.self, forKey: .facilitating)
    let email = try container.decodeIfPresent(String.self, forKey: .email)
    let attendances = try container.decodeIfPresent([AttendanceModel].self, forKey: .attendances)

    self.init(
      id: id,
      active: active,
      facilitating: facilitating,
      primary: primary,
      firstName: firstName,
      lastName: lastName,
      prefix: prefix,
      phone: phone,
      email: email,
      attendances: attendances
    )
  }
}
