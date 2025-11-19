//
//  ChildrensVillageApiCompatible.swift
//
//  Created by Chris Kobrzak on 08/03/2022.
//

import Foundation

public protocol ChildrensVillageApiCompatible: Sendable {
  func requestToken(_ username: String, _ password: String) async throws -> TokenModel

  // Returns HTTP status code
  func requestPasswordReset( _ username: String) async throws -> Int

  // Returns HTTP status code
  func updatePassword(_ verificationToken: String, _ password: String) async throws -> Int

  // Returns created parent UUID
  func createParent(
    _ token: String,
    _ parent: NewParentRequestModel
  ) async throws -> UUID

  // Returns created pupil UUID
  func createPupilWithAssociations(
    _ token: String,
    _ pupil: NewPupilRequestModel,
    _ parentIds: [UUID],
    _ branchIds: [Int],
    _ dayIds: [Int]
  ) async throws -> UUID

  func createPupil(
    _ token: String,
    _ pupil: NewPupilRequestModel
  ) async throws -> UUID

  func updatePupilWithAssociations(
    _ token: String,
    _ pupilId: UUID,
    _ pupil: UpdatePupilRequestModel,
    _ parentIds: [UUID],
    _ branchIds: [Int],
    _ dayIds: [Int]
  ) async throws

  func updatePupil(
    _ token: String,
    _ pupilId: UUID,
    _ pupil: UpdatePupilRequestModel
  ) async throws

  func updateParent(
    _ token: String,
    _ parentId: UUID,
    _ parent: UpdateParentRequestModel
  ) async throws

  func requestPupil(
    _ token: String,
    _ pupilId: UUID
  ) async throws -> PupilModel

  func requestParent(
    _ token: String,
    _ parentId: UUID
  ) async throws -> ParentModel

  func requestPupilSummaries(
    _ token: String
  ) async throws -> [PupilModel]

  func requestParentSummaries(
    _ token: String
  ) async throws -> [ParentModel]

  func requestPupilsRegister(
    _ token: String,
    _ branchId: Int,
    _ date: Date
  ) async throws -> [PupilModel]

  func requestFacilitatorsRegister(_ token: String, _ date: Date) async throws -> [ParentModel]

  func requestParentsRegister(_ token: String, _ branchId: Int, _ date: Date) async throws -> [ParentModel]

  func clockOnPupil(
    _ token: String,
    _ pupilId: UUID,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnConfirming

  func clockOnFacilitator(
    _ token: String,
    _ facilitatorId: UUID,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnConfirming

  func revertPupilClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws

  func revertFacilitatorClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws

  func clockOffPupil(
    _ token: String,
    _ attendanceId: Int,
    _ date: Date?
  ) async throws

  func updatePupilParents(
    _ token: String,
    _ pupilId: UUID,
    _ parentIds: [UUID]
  ) async throws

  func updatePupilBranches(
    _ token: String,
    _ pupilId: UUID,
    _ branchIds: [Int]
  ) async throws

  func updatePupilDaysOfWeek(
    _ token: String,
    _ pupilId: UUID,
    _ dayIds: [Int]
  ) async throws
}
