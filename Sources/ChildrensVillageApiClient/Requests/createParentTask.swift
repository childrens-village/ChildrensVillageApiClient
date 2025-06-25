//
//  createParentTask.swift
//
//
//  Created on 25/06/2025.
//

import Foundation
import JwtApiClient

func createParentTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ parent: NewParentRequestModel
) async throws -> ParentModel {
  let endpoint = buildParentsUrlComponent().url!

  let body: [String: Any] = [
    "active": parent.active,
    "facilitating": parent.facilitating,
    "primary": true,
    "prefix": parent.prefix.rawValue,
    "firstName": parent.firstName,
    "lastName": parent.lastName,
    "phone": parent.phone,
    "email": parent.email
  ]

  return try await apiClient.post(url: endpoint, dictionary: body, token: token)
}

fileprivate func buildParentsUrlComponent() -> URLComponents {
  let path = "/parents"

  return buildUrlComponent(path)
}
