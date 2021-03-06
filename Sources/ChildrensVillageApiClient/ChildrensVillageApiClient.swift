//
//  ChildrensVillageApiClient.swift
//
//  Created by Chris Kobrzak on 08/03/2022.
//

import Foundation
import JwtApiClient

public struct ChildrensVillageApiClient: ChildrensVillageApiCompatible {
  public init() {}

  public func requestToken(
    _ username: String,
    _ password: String
  ) async throws -> TokenResponse {
    try await requestTokenTask(username, password)
  }

  public func requestPupilsRegister(
    _ token: String,
    _ branchId: Int,
    _ date: Date
  ) async throws -> [Pupil] {
    try await requestPupilsRegisterTask(token, branchId, date)
  }

  public func requestFacilitatorsRegister(
    _ token: String,
    _ date: Date
  ) async throws -> [Parent] {
    try await requestFacilitatorsRegisterTask(token, date)
  }

  public func clockOnPupil(
    _ token: String,
    _ pupilId: String,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnResponse{
    try await clockOnPupilTask(token, pupilId, branchId, date)
  }

  public func clockOnFacilitator(
    _ token: String,
    _ facilitatorId: String,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnResponse{
    try await clockOnFacilitatorTask(token, facilitatorId, branchId)
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
}
