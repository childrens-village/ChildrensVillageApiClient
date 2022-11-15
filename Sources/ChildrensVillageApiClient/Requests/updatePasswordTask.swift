//
//  updatePasswordTask.swift
//  
//
//  Created by Chris Kobrzak on 15/11/2022.
//

import Foundation
import JwtApiClient

fileprivate let serverErrorCode = 500

func updatePasswordTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ verificationToken: String,
  _ password: String
) async throws -> Int {
  let endpoint = buildPasswordUpdateUrlComponent().url!

  let payload: [String: Any] = [
    "verificationToken": verificationToken,
    "password": password
  ]

  let response: URLResponse = try await apiClient.put(url: endpoint, dictionary: payload)

  guard let httpResponse = response as? HTTPURLResponse else {
    return serverErrorCode
  }

  return httpResponse.statusCode
}

fileprivate func buildPasswordUpdateUrlComponent() -> URLComponents {
  let path = "/users/verified/passwords"

  return buildUrlComponent(path)
}
