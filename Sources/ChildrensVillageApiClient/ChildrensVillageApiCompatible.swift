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

  func requestPupil(
    _ token: String,
    _ pupilId: UUID
  ) async throws -> PupilModel

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
}
