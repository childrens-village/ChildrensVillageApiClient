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
) async throws -> UUID {
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

  let createdParent: ParentModel = try await apiClient.post(url: endpoint, dictionary: body, token: token)
  return createdParent.id
}

fileprivate func buildParentsUrlComponent() -> URLComponents {
  let path = "/parents"

  return buildUrlComponent(path)
}
