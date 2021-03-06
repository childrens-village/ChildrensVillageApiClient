import Foundation

public struct Branch: Decodable {
  public let id: Int
  public let name: String
  public let geolocation: Geolocation
  public let postcode: String
  public let address: String
  public let pupils: [Pupil]?
  public let daysOfWeek: [PupilsByDay]?
}
