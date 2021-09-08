import Foundation

public struct PupilsByDayByBranch: Decodable {
  public let id: Int
  public let name: String
  public let geolocation: Geolocation
  public let address: String
  public let daysOfWeek: [PupilsByDay]
}
