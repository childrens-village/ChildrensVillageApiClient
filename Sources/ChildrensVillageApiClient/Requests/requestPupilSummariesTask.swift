//
//  requestPupilSummariesTask.swift
//
//
//  Created on 25/06/2025.
//

import Foundation
import JwtApiClient

func requestPupilSummariesTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String
) async throws -> [PupilSummaryModel] {
  let urlFilter = buildPupilSummariesRequestFilter()
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildPupilSummariesUrlComponent(filter: filterJson).url!

  return try await apiClient.get(url: endpoint, token: token)
}

fileprivate func buildPupilSummariesUrlComponent(filter: String) -> URLComponents {
  let path = "/pupils"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
