//
//  requestPasswordResetTask.swift
//
//
//  Created by Chris Kobrzak on 12/11/2022.
//

import Foundation
import JwtApiClient

fileprivate let serverErrorCode = 500

func requestPasswordResetTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ username: String
) async throws -> Int {
  let endpoint = buildPasswordResetUrlComponent().url!

  let payload: [String: Any] = [
    "email": username
  ]

  let response: URLResponse = try await apiClient.post(url: endpoint, dictionary: payload)

  guard let httpResponse = response as? HTTPURLResponse else {
    return serverErrorCode
  }

  return httpResponse.statusCode
}

fileprivate func buildPasswordResetUrlComponent() -> URLComponents {
  let path = "/users/anonymous/password-resets"

  return buildUrlComponent(path)
}
