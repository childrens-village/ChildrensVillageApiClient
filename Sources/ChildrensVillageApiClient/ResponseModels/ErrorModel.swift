import Foundation

public struct ErrorModel: Decodable, Sendable {
  let error: ApiError
}
