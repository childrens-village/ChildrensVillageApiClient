//
//  ChildrensVillageApiCompatible.swift
//
//  Created by Chris Kobrzak on 08/03/2022.
//

import Foundation

public protocol ChildrensVillageApiCompatible {
  func requestToken(_ username: String, _ password: String) async throws -> TokenResponse

  func requestPupil(
    _ token: String,
    _ pupilId: UUID
  ) async throws -> Pupil

  func requestPupilsRegister(
    _ token: String,
    _ branchId: Int,
    _ date: Date
  ) async throws -> [Pupil]

  func requestFacilitatorsRegister(_ token: String, _ date: Date) async throws -> [Parent]

  func clockOnPupil(
    _ token: String,
    _ pupilId: UUID,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnResponse

  func clockOnFacilitator(
    _ token: String,
    _ facilitatorId: UUID,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnResponse

  func revertPupilClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws

  func revertFacilitatorClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws
}
