//
//  requestToken.swift
//  Utility for logging in and obtaining the token for future requests.
//
//  Created by Chris Kobrzak on 04/09/2021.
//

import Foundation
import JwtApiClient

@available(iOS 15.0.0, *)
public func requestToken<T: Decodable>(_ username: String, _ password: String) async throws -> T {
  let endpoint = buildTokenUrlComponent().url
  let credentials = [
    "email": username,
    "password": password
  ]

  return try await requestTokenWithJsonCredentials(endpoint!, credentials)
}

func buildTokenUrlComponent() -> URLComponents {
  let path = "/users/login"

  return buildUrlComponent(path)
}
