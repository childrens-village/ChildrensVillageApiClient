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
) async throws -> PupilResponse {
  let urlFilter = buildPupilRequestFilter()
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildPupilUrlComponent(pupilId: pupilId, filter: filterJson).url!

  return try await apiClient.get(url: endpoint, token: token)
}

fileprivate func buildPupilUrlComponent(pupilId: UUID, filter: String) -> URLComponents {
  let sanitisedPupilId = pupilId.uuidString.lowercased()
  let path = "/pupils/\(sanitisedPupilId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
