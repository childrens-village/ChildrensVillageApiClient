import Foundation

public struct ErrorResponse: Decodable {
  let error: ApiError
}
