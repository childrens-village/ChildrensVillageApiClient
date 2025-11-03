//
//  updateParentTask.swift
//
//
//  Created on 2/11/2025.
//

import Foundation
import JwtApiClient

fileprivate let serverErrorCode = 500

func updateParentTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ parentId: UUID,
  _ parent: UpdateParentRequestModel
) async throws {
  let endpoint = buildParentUrlComponent(parentId: parentId).url!

  var body: [String: Any] = [:]

  if let active = parent.active {
    body["active"] = active
  }
  if let facilitating = parent.facilitating {
    body["facilitating"] = facilitating
  }
  if let prefix = parent.prefix {
    body["prefix"] = prefix.rawValue
  }
  if let firstName = parent.firstName {
    body["firstName"] = firstName
  }
  if let lastName = parent.lastName {
    body["lastName"] = lastName
  }
  if let phone = parent.phone {
    body["phone"] = phone
  }
  if let email = parent.email {
    body["email"] = email
  }

  let response: URLResponse = try await apiClient.patch(url: endpoint, dictionary: body)

  guard let httpResponse = response as? HTTPURLResponse,
      200...299 ~= httpResponse.statusCode else {
    throw URLError(.badServerResponse)
  }
}

fileprivate func buildParentUrlComponent(parentId: UUID) -> URLComponents {
  let path = "/parents/\(parentId)"

  return buildUrlComponent(path)
}