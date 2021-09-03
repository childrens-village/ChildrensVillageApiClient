import Foundation

public struct PupilsByDayByBranch: Decodable {
  let id: Int
  let name: String
  let geolocation: Geolocation
  let address: String
  let daysOfWeek: [PupilsByDay]
}
