//
//  clockOnFacilitatorTask.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

#warning("TODO: Unit test")
func clockOnFacilitatorTask<T: Decodable>(
  _ token: String,
  _ facilitatorId: String,
  _ branchId: Int,
  _ date: Date? = Date()
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