import Foundation

struct ApiError: Decodable {
  let statusCode: Int
  let name: String
  let message: String
}

extension ApiError: Error {}
