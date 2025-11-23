//
//  createPupilWithAssociationsTask.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 18/11/2025.
//


import Foundation
import JwtApiClient

func createPupilWithAssociationsTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupil: NewPupilRequestModel,
  _ parentIds: [UUID],
  _ branchIds: [Int],
  _ dayIds: [Int]
) async throws -> UUID {
  let pupilId = try await createPupilTask(apiClient: apiClient, token, pupil)

  async let parentsRelationTask: Void = updatePupilParentsTask(apiClient: apiClient, token, pupilId, parentIds)
  async let branchesRelationTask: Void = createPupilBranchesTask(apiClient: apiClient, token, pupilId, branchIds)
  async let daysRelationTask: Void = createPupilDaysOfWeekTask(apiClient: apiClient, token, pupilId, dayIds)

  _ = try await parentsRelationTask
  _ = try await branchesRelationTask
  _ = try await daysRelationTask

  return pupilId
}
