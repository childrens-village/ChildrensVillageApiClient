import Foundation

public struct GeolocationModel: Decodable, Sendable {
  public let latitude: Float
  public let longitude: Float

  enum CodingKeys: String, CodingKey {
    case latitude = "x"
    case longitude = "y"
  }
}
