//
//  requestPupilsRegisterTask.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation
import JwtApiClient

// TODO: Unit test
func requestPupilsRegisterTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ branchId: Int,
  _ date: Date
) async throws -> [PupilModel] {
//  If a pupil was present on a given day but is no longer active in the system,
//  the main request below would exclude them. As a work-around, we are requesting
//  all pupils clocked on that day and passing this list to the main one to be used
//  as an additional filter
  var clockedOnPupilIds = [UUID()]

  do {
    let attendances: [AttendanceModel] = try await requestAttendances(token, branchId, date)
    clockedOnPupilIds = attendances.map { $0.pupilId! }
  } catch {}

  return try await requestAllPupilsRegisterTask(token, branchId, date, clockedOnPupilIds)
}

func requestAllPupilsRegisterTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ branchId: Int,
  _ date: Date,
  _ clockedOnPupilIds: [UUID]
) async throws -> [PupilModel] {
  let urlFilter = buildPupilsRegisterRequestFilter(date, clockedOnPupilIds)
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildDailyRegisterUrlComponent(branchId: branchId, filter: filterJson).url!

  let response: BranchModel = try await apiClient.get(url: endpoint, token: token)

  return response.daysOfWeek?.first?.pupils ?? []
}

fileprivate func buildDailyRegisterUrlComponent(branchId: Int, filter: String) -> URLComponents {
  let path = "/branches/\(branchId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
