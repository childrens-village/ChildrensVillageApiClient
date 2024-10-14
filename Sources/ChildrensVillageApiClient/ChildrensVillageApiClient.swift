//
//  ChildrensVillageApiClient.swift
//
//  Created by Chris Kobrzak on 08/03/2022.
//

import Foundation
import JwtApiClient

public struct ChildrensVillageApiClient: ChildrensVillageApiCompatible, Sendable {
  public init() {}

  public func requestToken(
    _ username: String,
    _ password: String
  ) async throws -> TokenModel {
    try await requestTokenTask(username, password)
  }

  public func requestPasswordReset(_ username: String) async throws -> Int {
    return try await requestPasswordResetTask(username)
  }

  public func updatePassword(_ verificationToken: String, _ password: String) async throws -> Int {
    return try await updatePasswordTask(verificationToken, password)
  }

  public func requestPupil(_ token: String, _ pupilId: UUID) async throws -> PupilModel {
    try await requestPupilTask(token, pupilId)
  }

  public func requestPupilsRegister(
    _ token: String,
    _ branchId: Int,
    _ date: Date
  ) async throws -> [PupilModel] {
    try await requestPupilsRegisterTask(token, branchId, date)
  }

  public func requestFacilitatorsRegister(
    _ token: String,
    _ date: Date
  ) async throws -> [ParentModel] {
    try await requestFacilitatorsRegisterTask(token, date)
  }

  public func requestParentsRegister(_ token: String, _ branchId: Int, _ date: Date) async throws -> [ParentModel] {
    try await requestParentsRegisterTask(token, branchId, date)
  }

  public func clockOnPupil(
    _ token: String,
    _ pupilId: UUID,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnConfirming {
    try await clockOnPupilTask(token, pupilId, branchId, date)
  }

  public func clockOnFacilitator(
    _ token: String,
    _ facilitatorId: UUID,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnConfirming {
    try await clockOnFacilitatorTask(token, facilitatorId, branchId, date)
  }

  public func revertPupilClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws {
    try await revertPupilClockOnTask(token, attendanceId)
  }

  public func revertFacilitatorClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws {
    try await revertFacilitatorClockOnTask(token, attendanceId)
  }

  public func clockOffPupil(
    _ token: String,
    _ attendanceId: Int,
    _ date: Date?
  ) async throws {
    try await clockOffPupilTask(token, attendanceId, date)
  }
}
