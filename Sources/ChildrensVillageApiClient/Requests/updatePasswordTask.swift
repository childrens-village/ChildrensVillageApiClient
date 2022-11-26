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
  let endpoint = buildPasswordUpdateUrlComponent(verificationToken).url!

  let payload: [String: String] = [
    "password": password
  ]

  let response: URLResponse = try await apiClient.patch(url: endpoint, dictionary: payload)

  guard let httpResponse = response as? HTTPURLResponse else {
    return serverErrorCode
  }

  return httpResponse.statusCode
}

fileprivate func buildPasswordUpdateUrlComponent(_ verificationToken: String) -> URLComponents {
  let path = "/users/\(verificationToken)"

  return buildUrlComponent(path)
}
