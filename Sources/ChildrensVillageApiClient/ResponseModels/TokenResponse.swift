//
//  TokenResponse.swift
//  Successful authentication model with an extension that throws the
//  generic ErrorResponse error for easy exception handling.
//
//  The extension is a copy of the code snippet posted under
//  https://stackoverflow.com/a/69065776/764906
//
//  Created by Chris Kobrzak on 04/09/2021.
//  Extended by Rob Napier on 05/09/2021.
//

import Foundation

public struct TokenResponse: Decodable {
  public let token: String
}

extension TokenResponse {
  enum CodingKeys: CodingKey {
    case token
  }

  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
          let token = try? container.decode(String.self, forKey: .token) else {
        throw try ErrorResponse(from: decoder).error
    }

    self.init(token: token)
  }
}
