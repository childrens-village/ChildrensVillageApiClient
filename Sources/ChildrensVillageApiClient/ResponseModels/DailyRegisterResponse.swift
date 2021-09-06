import Foundation

public typealias DailyRegisterResponse = PupilsByDayByBranch

extension DailyRegisterResponse {
  enum CodingKeys: CodingKey {
    case id
    case name
    case geolocation
    case address
    case daysOfWeek
  }

  public init(from decoder: Decoder) throws {
    if let container = try? decoder.container(keyedBy: CodingKeys.self),
       let id = try? container.decode(Int.self, forKey: .id),
       let name = try? container.decode(String.self, forKey: .name),
       let geolocation = try? container.decode(Geolocation.self, forKey: .geolocation),
       let address = try? container.decode(String.self, forKey: .address),
       let daysOfWeek = try? container.decode([PupilsByDay].self, forKey: .daysOfWeek) {
      self.init(id: id, name: name, geolocation: geolocation, address: address, daysOfWeek: daysOfWeek)
    } else {
      throw try ErrorResponse(from: decoder).error
    }
  }
}
