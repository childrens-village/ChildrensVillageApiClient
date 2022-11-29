//
//  clockOffPupilTask.swift
//  
//
//  Created by Chris Kobrzak on 29/11/2022.
//

import Foundation
import JwtApiClient

func clockOffPupilTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ attendanceId: Int,
  _ date: Date? = Date()
) async throws {
  let endpoint = buildClockOffUrlComponent(attendanceId).url!
  let (_, time) = getLocalIsoTimeParts(date ?? Date())

  let body: [String: String] = [
    "clockOffTime": time
  ]

  try await apiClient.patch(url: endpoint, dictionary: body, token: token)
}

// TODO: Dry it
fileprivate func buildClockOffUrlComponent(_ attendanceId: Int) -> URLComponents {
  let path = "/attendances/\(attendanceId)"

  return buildUrlComponent(path)
}
