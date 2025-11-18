//
//  createPupilDaysOfWeekTask.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 18/11/2025.
//

import Foundation
import JwtApiClient

func createPupilDaysOfWeekTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID,
  _ dayIds: [Int]
) async throws {
  let endpoint = buildPupilDaysOfWeekUrlComponent(pupilId: pupilId).url!

  for dayId in dayIds {
    let body: [String: Int] = [
      "id": dayId
    ]

    let _ = try await apiClient.post(
      url: endpoint,
      dictionary: body,
      token: token
    )
  }
}

fileprivate func buildPupilDaysOfWeekUrlComponent(pupilId: UUID) -> URLComponents {
  let path = "/pupils/\(pupilId)/days-of-week"

  return buildUrlComponent(path)
}
