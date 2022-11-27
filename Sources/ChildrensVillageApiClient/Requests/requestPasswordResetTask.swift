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
  _ email: String
) async throws -> Int {
  let endpoint = buildPasswordResetUrlComponent(email: email).url!

//  TODO: We need a method that does not require the dictionary
  let payload: [String: String] = [:]

  let response: URLResponse = try await apiClient.post(url: endpoint, dictionary: payload)

  guard let httpResponse = response as? HTTPURLResponse else {
    return serverErrorCode
  }

  return httpResponse.statusCode
}

fileprivate func buildPasswordResetUrlComponent(email: String) -> URLComponents {
  let encryptedEmail = email.data(using: .utf8)?.base64EncodedString()
  let path = "/users/\(encryptedEmail ?? "invalid-email")/password-resets"

  return buildUrlComponent(path)
}
