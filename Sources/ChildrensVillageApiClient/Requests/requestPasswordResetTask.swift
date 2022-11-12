//
//  requestPasswordResetTask.swift
//
//
//  Created by Chris Kobrzak on 12/11/2022.
//

import Foundation
import JwtApiClient

func requestPasswordResetTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ username: String
) async throws {
  let endpoint = buildPasswordResetUrlComponent().url!

  let payload: [String: Any] = [
    "email": username,
  ]

  try await apiClient.post(url: endpoint, dictionary: payload)
}

fileprivate func buildPasswordResetUrlComponent() -> URLComponents {
  let path = "/users/anonymous/password-resets"

  return buildUrlComponent(path)
}
