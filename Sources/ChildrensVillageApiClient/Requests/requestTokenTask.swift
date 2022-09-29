//
//  requestTokenTask.swift
//  Utility for logging in and obtaining the token for future requests.
//
//  Created by Chris Kobrzak on 04/09/2021.
//

import Foundation
import JwtApiClient

func requestTokenTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ username: String,
  _ password: String
) async throws -> TokenModel {
  let endpoint = buildTokenUrlComponent().url
  let credentials = [
    "email": username,
    "password": password
  ]

  return try await apiClient.post(url: endpoint!, dictionary: credentials)
}

func buildTokenUrlComponent() -> URLComponents {
  let path = "/users/login"

  return buildUrlComponent(path)
}
