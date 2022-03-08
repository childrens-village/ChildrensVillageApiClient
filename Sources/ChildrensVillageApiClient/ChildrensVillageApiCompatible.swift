//
//  ChildrensVillageApiCompatible.swift
//
//  Created by Chris Kobrzak on 08/03/2022.
//

import Foundation

public protocol ChildrensVillageApiCompatible {
  func requestToken<T: Decodable>(_ username: String, _ password: String) async throws -> T

  func requestPupilsRegister<T: Decodable>(
    _ token: String,
    _ branchId: Int,
    _ date: Date
  ) async throws -> T

  func requestFacilitatorsRegister<T: Decodable>(_ token: String, _ date: Date) async throws -> T

  func clockOnPupil<T: Decodable>(
    _ token: String,
    _ pupilId: String,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> T

  func clockOnFacilitator<T: Decodable>(
    _ token: String,
    _ facilitatorId: String,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> T

  func revertPupilClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws

  func revertFacilitatorClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws
}
