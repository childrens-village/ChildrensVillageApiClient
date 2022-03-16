//
//  requestFacilitatorsRegisterTask.swift
//  File
//
//  Created by Chris Kobrzak on 20/10/2021.
//

import Foundation
import JwtApiClient

func requestFacilitatorsRegisterTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ date: Date
) async throws -> [Parent] {
  let urlFilter = buildFacilitatorsRegisterRequestFilter(date)
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildFacilitatorsUrlComponent(filter: filterJson).url!

  return try await apiClient.get(url: endpoint, token: token)
}

func buildFacilitatorsUrlComponent(filter: String) -> URLComponents {
  let path = "/parents"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
