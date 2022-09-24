import Foundation

public typealias DailyRegisterResponse = BranchModel

extension DailyRegisterResponse {
  enum CodingKeys: CodingKey {
    case id
    case name
    case geolocation
    case postcode
    case address
    case daysOfWeek
  }

  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
       let id = try? container.decode(Int.self, forKey: .id),
       let name = try? container.decode(String.self, forKey: .name),
       let geolocation = try? container.decode(GeolocationModel.self, forKey: .geolocation),
       let postcode = try? container.decode(String.self, forKey: .postcode),
       let address = try? container.decode(String.self, forKey: .address),
       let daysOfWeek = try? container.decode([DayOfWeekModel].self, forKey: .daysOfWeek) else {
      throw try ErrorResponse(from: decoder).error
    }

    self.init(
      id: id,
      name: name,
      geolocation: geolocation,
      postcode: postcode,
      address: address,
      pupils: nil,
      daysOfWeek: daysOfWeek
    )
  }
}
