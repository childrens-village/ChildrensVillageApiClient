//
//  updatePupilBranchesTask.swift
//
//  Created on 18/11/2025.
//

import Foundation
import JwtApiClient

func updatePupilBranchesTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID,
  _ branchIds: [Int]
) async throws {
  let endpoint = buildPupilBranchesUrlComponent(pupilId: pupilId).url!

  let branches: [[String: Int]] = branchIds.map { branchId in
    ["id": branchId]
  }

  let _ = try await apiClient.put(
    url: endpoint,
    dictionary: ["branches": branches],
    token: token
  )
}

fileprivate func buildPupilBranchesUrlComponent(pupilId: UUID) -> URLComponents {
  let path = "/pupils/\(pupilId)/branches"

  return buildUrlComponent(path)
}
