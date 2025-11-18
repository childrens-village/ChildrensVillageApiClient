//
//  updatePupilParents.swift
//
//  Created on 18/11/2025.
//

import Foundation
import JwtApiClient

func updatePupilParentsTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID,
  _ parentIds: [UUID]
) async throws {
  let deleteEndpoint = buildDeleteParentsUrlComponent(pupilId: pupilId).url!
  let createEndpoint = buildCreateParentAssociationUrlComponent(pupilId: pupilId).url!

  try await apiClient.delete(url: deleteEndpoint, token: token)

  for parentId in parentIds {
    let body: [String: String] = [
      "id": parentId.uuidString
    ]

    let _ = try await apiClient.post(
      url: createEndpoint,
      dictionary: body,
      token: token
    )
  }
}

fileprivate func buildDeleteParentsUrlComponent(pupilId: UUID) -> URLComponents {
  let path = "/pupils/\(pupilId)/parents"

  return buildUrlComponent(path)
}

fileprivate func buildCreateParentAssociationUrlComponent(pupilId: UUID) -> URLComponents {
  let path = "/pupils/\(pupilId)/parents"

  return buildUrlComponent(path)
}