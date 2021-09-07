//
//  clockOnPupil.swift
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation
import JwtApiClient

public func clockOnPupil<T: Decodable>(
  pupilId: String,
  branchId: Int,
  token: String,
  date: Date? = Date()
) async throws -> T {
  let endpoint = buildClockOnUrlComponent().url!
  let (date, time, _) = getLocalIsoTimeParts(date ?? Date())

  let body: [String: Any] = [
    "pupilId": pupilId,
    "branchId": branchId,
    "date": date,
    "clockOnTime": time
  ]

  return try await postJsonDictionaryWithToken(endpoint, token: token, dictionary: body)
}

fileprivate func buildClockOnUrlComponent() -> URLComponents {
  let path = "/attendances"

  return buildUrlComponent(path)
}
