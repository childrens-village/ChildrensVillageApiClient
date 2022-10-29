//
//  requestAttendances.swift
//
//  Created by Chris Kobrzak on 29/10/2022.
//

import Foundation
import JwtApiClient

// TODO: Unit test
func requestAttendances(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ branchId: Int,
  _ date: Date
) async throws -> [AttendanceModel] {
  let urlFilter = buildAttendancesRequestFilter(branchId, date)
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildAttendancesUrlComponent(filter: filterJson).url!

  return try await apiClient.get(url: endpoint, token: token)
}

fileprivate func buildAttendancesUrlComponent(filter: String) -> URLComponents {
  let path = "/attendances"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
