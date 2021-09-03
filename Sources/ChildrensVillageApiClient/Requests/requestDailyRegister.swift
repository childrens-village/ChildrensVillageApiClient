//
//  requestDailyRegister.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation
import JwtApiClient

let baseApiUrl = "https://childrens-village.co.uk/api"

@available(iOS 15.0.0, *)
public func requestDailyRegister(
  branchId: Int,
  dayOfWeek: DayOfWeek,
  token: String
) async throws -> [Pupil] {
  let urlFilter = buildDailyRegisterRequestFilter(dayOfWeek)
  let filterJson = JSONEncoder.encode(from: urlFilter)
  // TODO URL decoding helper needed
  let escapedJson = filterJson.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
  let endpoint = "\(baseApiUrl)/branches/\(branchId)?filter=\(escapedJson ?? "empty")"

  let result: PupilsByDayByBranch = try await requestWithAuthorisation(endpoint, token: token)

  return result.daysOfWeek.first?.pupils ?? []
}
