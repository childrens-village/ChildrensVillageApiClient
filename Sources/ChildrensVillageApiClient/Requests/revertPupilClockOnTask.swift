//
//  revertPupilClockOnTask.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

func revertPupilClockOnTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ attendanceId: Int
) async throws {
  let endpoint = buildRevertClockOnUrlComponent(attendanceId: attendanceId).url!

  try await apiClient.delete(url: endpoint, token: token)
}

fileprivate func buildRevertClockOnUrlComponent(attendanceId: Int) -> URLComponents {
  let path = "/attendances/\(attendanceId)"

  return buildUrlComponent(path)
}
