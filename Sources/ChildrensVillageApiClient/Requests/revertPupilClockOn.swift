//
//  revertPupilClockOn.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

public func revertPupilClockOn(
  token: String,
  attendanceId: Int
) async throws {
  let endpoint = buildRevertClockOnUrlComponent(attendanceId: attendanceId).url!

  try await deleteWithToken(endpoint, token: token)
}

fileprivate func buildRevertClockOnUrlComponent(attendanceId: Int) -> URLComponents {
  let path = "/attendances/\(attendanceId)"

  return buildUrlComponent(path)
}
