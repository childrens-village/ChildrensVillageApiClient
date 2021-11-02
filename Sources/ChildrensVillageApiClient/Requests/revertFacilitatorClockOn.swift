//
//  revertFacilitatorClockOn.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

#warning("TODO: Unit test")
public func revertFacilitatorClockOn(
  token: String,
  attendanceId: Int
) async throws {
  let endpoint = buildRevertClockOnUrlComponent(attendanceId: attendanceId).url!

  try await deleteWithToken(endpoint, token: token)
}

fileprivate func buildRevertClockOnUrlComponent(attendanceId: Int) -> URLComponents {
  let path = "/parent-attendances/\(attendanceId)"

  return buildUrlComponent(path)
}
