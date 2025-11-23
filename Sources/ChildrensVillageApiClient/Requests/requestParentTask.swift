//
//  requestParentTask.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 19/11/2025.
//

import Foundation
import JwtApiClient

func requestParentTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ parentId: UUID
) async throws -> ParentModel {
  let urlFilter = buildParentRequestFilter()
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildParentUrlComponent(parentId: parentId, filter: filterJson).url!

  return try await apiClient.get(url: endpoint, token: token)
}

fileprivate func buildParentUrlComponent(parentId: UUID, filter: String) -> URLComponents {
  let sanitisedParentId = parentId.uuidString.lowercased()
  let path = "/parents/\(sanitisedParentId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
