//
//  requestPupilsRegisterTask.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation
import JwtApiClient

func requestPupilsRegisterTask<T: Decodable>(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ branchId: Int,
  _ date: Date
) async throws -> T {
  let urlFilter = buildPupilsRegisterRequestFilter(date)
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildDailyRegisterUrlComponent(branchId: branchId, filter: filterJson).url!

  return try await apiClient.get(url: endpoint, token: token)
}

func buildDailyRegisterUrlComponent(branchId: Int, filter: String) -> URLComponents {
  let path = "/branches/\(branchId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
