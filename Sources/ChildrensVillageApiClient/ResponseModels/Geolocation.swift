import Foundation

public struct Geolocation: Decodable {
  let latitude: Float
  let longitude: Float

  enum CodingKeys: String, CodingKey {
    case latitude = "x"
    case longitude = "y"
  }
}
