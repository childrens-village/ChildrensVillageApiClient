import Foundation

extension BranchModel {
  enum CodingKeys: CodingKey {
    case id
    case name
    case geolocation
    case postcode
    case address
    case daysOfWeek
    case pupils
  }

  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
       let id = try? container.decode(Int.self, forKey: .id),
       let name = try? container.decode(String.self, forKey: .name),
       let geolocation = try? container.decode(GeolocationModel.self, forKey: .geolocation),
       let postcode = try? container.decode(String.self, forKey: .postcode),
       let address = try? container.decode(String.self, forKey: .address) else {
      throw try ErrorModel(from: decoder).error
    }

    let daysOfWeek = try container.decodeIfPresent([DayOfWeekModel].self, forKey: .daysOfWeek)
    let pupils = try container.decodeIfPresent([PupilModel].self, forKey: .pupils)

    self.init(
      id: id,
      name: name,
      geolocation: geolocation,
      postcode: postcode,
      address: address,
      pupils: pupils,
      daysOfWeek: daysOfWeek
    )
  }
}
