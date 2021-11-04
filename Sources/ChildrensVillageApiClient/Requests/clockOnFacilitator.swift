//
//  clockOnFacilitator.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

#warning("TODO: Unit test")
public func clockOnFacilitator<T: Decodable>(
  token: String,
  facilitatorId: String,
  branchId: Int,
  date: Date? = Date()
) async throws -> T {
  let endpoint = buildClockOnUrlComponent().url!
  let (date, time, _) = getLocalIsoTimeParts(date ?? Date())

  let body: [String: Any] = [
    "parentId": facilitatorId,
    "branchId": branchId,
    "date": date,
    "clockOnTime": time
  ]

  return try await postJsonDictionaryWithToken(endpoint, token: token, dictionary: body)
}

fileprivate func buildClockOnUrlComponent() -> URLComponents {
  let path = "/parent-attendances"

  return buildUrlComponent(path)
}
