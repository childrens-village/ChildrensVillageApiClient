//
//  requestParentsRegisterTask.swift
//  
//
//  Created by Chris Kobrzak on 08/12/2022.
//

import Foundation
import JwtApiClient

// TODO: Unit test
func requestParentsRegisterTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ branchId: Int,
  _ date: Date
) async throws -> [ParentModel] {
//  If a pupil was present on a given day but is no longer active in the system,
//  the main request below would exclude them. As a work-around, we are requesting
//  all pupils clocked on that day and passing this list to the main one to be used
//  as an additional filter
  var clockedOnPupilIds = [UUID()]

  do {
    let attendances: [AttendanceModel] = try await requestAttendances(token, branchId, date)
    clockedOnPupilIds = attendances.map { $0.pupilId! }
  } catch {}

  return try await requestAllParentsRegisterTask(token, branchId, date, clockedOnPupilIds)
}

func requestAllParentsRegisterTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ branchId: Int,
  _ date: Date,
  _ clockedOnPupilIds: [UUID]
) async throws -> [ParentModel] {
  let urlFilter = buildParentsRegisterRequestFilter(date, clockedOnPupilIds)
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildBranchUrlComponent(branchId: branchId, filter: filterJson).url!

  let response: BranchModel = try await apiClient.get(url: endpoint, token: token)

  return extractParents(response)
}

fileprivate func extractParents(_ response: BranchModel) -> [ParentModel] {
  var allParents = [ParentModel]()
  var parentIds = Set<UUID>()

  for pupil in response.daysOfWeek?.first?.pupils ?? [] {
    guard let parents = pupil.parents, !parents.isEmpty else {
      continue
    }

    for parent in parents {
      guard !parentIds.contains(parent.id) else {
        continue
      }

      parentIds.insert(parent.id)
      allParents.append(parent)
    }
  }

  return allParents.sorted(by: { $0.firstName < $1.firstName })
}
