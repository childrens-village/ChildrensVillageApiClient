//
//  updatePupilDaysOfWeekTask.swift
//
//  Created on 18/11/2025.
//

import Foundation
import JwtApiClient

func updatePupilDaysOfWeekTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID,
  _ dayIds: [Int]
) async throws {
  let endpoint = buildPupilDaysOfWeekUrlComponent(pupilId: pupilId).url!

  let days: [[String: Int]] = dayIds.map { dayId in
    ["id": dayId]
  }

  try await apiClient.put(url: endpoint, dictionary: ["days": days], token: token)
}

fileprivate func buildPupilDaysOfWeekUrlComponent(pupilId: UUID) -> URLComponents {
  let path = "/pupils/\(pupilId)/days-of-week"

  return buildUrlComponent(path)
}
