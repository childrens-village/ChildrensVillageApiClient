import Foundation

extension JSONEncoder {
  static func encode<T: Encodable>(from data: T) -> String {
    let jsonEncoder = JSONEncoder()

    do {
      let json = try jsonEncoder.encode(data)

      guard let jsonString = String(data: json, encoding: .utf8) else {
        return ""
      }

      return jsonString
    } catch {
      print(error.localizedDescription)
    }

    // TODO Throw here
    return ""
  }
}
