//
//  requestDailyRegister.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation
import JwtApiClient

public func requestDailyRegister<T: Decodable>(
  branchId: Int,
  date: Date,
  token: String
) async throws -> T {
  let urlFilter = buildDailyRegisterRequestFilter(date)
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildDailyRegisterUrlComponent(branchId: branchId, filter: filterJson).url!

  return try await getJsonWithToken(endpoint, token: token)
}

func buildDailyRegisterUrlComponent(branchId: Int, filter: String) -> URLComponents {
  let path = "/branches/\(branchId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
