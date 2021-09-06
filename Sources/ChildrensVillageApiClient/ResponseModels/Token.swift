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

struct Token: Decodable {
  let token: String
}

extension Token {
  enum CodingKeys: CodingKey {
    case token
  }

  init(from decoder: Decoder) throws {
    if let container = try? decoder.container(keyedBy: CodingKeys.self),
       let token = try? container.decode(String.self, forKey: .token) {
      self.init(token: token)
    } else {
      throw try TokenError(from: decoder).error
    }
  }
}
