//
//  clockOnFacilitatorTask.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

func clockOnFacilitatorTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ facilitatorId: UUID,
  _ branchId: Int,
  _ date: Date? = Date()
) async throws -> ClockOnModel {
  let endpoint = buildClockOnUrlComponent().url!
  let (date, time) = getLocalIsoTimeParts(date ?? Date())

  let body: [String: Any] = [
    "parentId": facilitatorId.uuidString,
    "branchId": branchId,
    "date": date,
    "clockOnTime": time
  ]

  return try await apiClient.post(url: endpoint, dictionary: body, token: token)
}

fileprivate func buildClockOnUrlComponent() -> URLComponents {
  let path = "/parent-attendances"

  return buildUrlComponent(path)
}
