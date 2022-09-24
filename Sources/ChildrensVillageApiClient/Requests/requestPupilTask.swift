//
//  requestPupilTask.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation
import JwtApiClient

func requestPupilTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID
) async throws -> Pupil {
  let urlFilter = buildPupilRequestFilter()
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildPupilUrlComponent(pupilId: pupilId, filter: filterJson).url!

  let response: PupilResponse = try await apiClient.get(url: endpoint, token: token)

  return Pupil(
    id: response.id,
    firstName: response.firstName,
    lastName: response.lastName,
    dateOfBirth: response.dateOfBirth,
    prefix: response.prefix,
    parents: response.parents,
    attendances: response.attendances,
    branches: response.branches,
    daysOfWeek: response.daysOfWeek
  )
}

fileprivate func buildPupilUrlComponent(pupilId: UUID, filter: String) -> URLComponents {
  let sanitisedPupilId = pupilId.uuidString.lowercased()
  let path = "/pupils/\(sanitisedPupilId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
