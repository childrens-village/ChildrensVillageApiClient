//
//  requestDailyRegister.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation
import JwtApiClient

@available(iOS 15.0.0, *)
public func requestDailyRegister<T: Decodable>(
  branchId: Int,
  dayOfWeek: DayOfWeek,
  token: String
) async throws -> T {
  let urlFilter = buildDailyRegisterRequestFilter(dayOfWeek)
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildDailyRegisterUrlComponent(branchId: branchId, filter: filterJson).url!

  return try await requestWithAuthorisation(endpoint, token: token)
}

func buildDailyRegisterUrlComponent(branchId: Int, filter: String) -> URLComponents {
  let path = "/branches/\(branchId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
