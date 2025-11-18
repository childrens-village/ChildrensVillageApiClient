//
//  createPupilBranchesTask.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 18/11/2025.
//

import Foundation
import JwtApiClient

func createPupilBranchesTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID,
  _ branchIds: [Int]
) async throws {
  let endpoint = buildPupilBranchesUrlComponent(pupilId: pupilId).url!

  for branchId in branchIds {
    let body = ["id": branchId]

    let _ = try await apiClient.post(
      url: endpoint,
      dictionary: body,
      token: token
    )
  }
}

fileprivate func buildPupilBranchesUrlComponent(pupilId: UUID) -> URLComponents {
  let path = "/pupils/\(pupilId)/branches"

  return buildUrlComponent(path)
}