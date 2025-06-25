//
//  requestParentSummariesTask.swift
//
//
//  Created on 25/06/2025.
//

import Foundation
import JwtApiClient

func requestParentSummariesTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String
) async throws -> [ParentSummaryModel] {
  let urlFilter = buildParentSummariesRequestFilter()
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildParentsUrlComponent(filter: filterJson).url!

  return try await apiClient.get(url: endpoint, token: token)
}

fileprivate func buildParentsUrlComponent(filter: String) -> URLComponents {
  let path = "/parents"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}