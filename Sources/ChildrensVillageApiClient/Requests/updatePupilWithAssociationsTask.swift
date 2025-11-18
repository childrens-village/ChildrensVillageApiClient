import Foundation
import JwtApiClient

func updatePupilWithAssociationsTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID,
  _ pupil: UpdatePupilRequestModel,
  _ parentIds: [UUID],
  _ branchIds: [Int],
  _ dayIds: [Int]
) async throws {
  try await updatePupilTask(apiClient: apiClient, token, pupilId, pupil)

  async let parentsUpdate: Void = updatePupilParentsTask(apiClient: apiClient, token, pupilId, parentIds)
  async let branchesUpdate: Void = updatePupilBranchesTask(apiClient: apiClient, token, pupilId, branchIds)
  async let daysUpdate: Void = updatePupilDaysOfWeekTask(apiClient: apiClient, token, pupilId, dayIds)

  _ = try await parentsUpdate
  _ = try await branchesUpdate
  _ = try await daysUpdate
}
