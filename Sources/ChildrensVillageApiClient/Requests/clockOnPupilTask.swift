//
//  clockOnPupilTask.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

func clockOnPupilTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: String,
  _ branchId: Int,
  _ date: Date? = Date()
) async throws -> ClockOnResponse {
  let endpoint = buildClockOnUrlComponent().url!
  let (date, time, _) = getLocalIsoTimeParts(date ?? Date())

  let body: [String: Any] = [
    "pupilId": pupilId,
    "branchId": branchId,
    "date": date,
    "clockOnTime": time
  ]

  return try await apiClient.post(url: endpoint, dictionary: body, token: token)
}

fileprivate func buildClockOnUrlComponent() -> URLComponents {
  let path = "/attendances"

  return buildUrlComponent(path)
}
