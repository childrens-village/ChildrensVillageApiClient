import Foundation

public struct ApiError: Decodable {
  public let statusCode: Int
  public let name: String
  public let message: String
}

extension ApiError: Error {}
