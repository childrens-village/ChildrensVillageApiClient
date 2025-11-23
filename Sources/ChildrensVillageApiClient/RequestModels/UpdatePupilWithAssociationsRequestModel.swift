//
//  UpdatePupilWithAssociationsRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created on 19/11/2025.
//

import Foundation

public struct UpdatePupilWithAssociationsRequestModel: Codable, Equatable, Sendable {
  // Core pupil data
  public let prefix: TitlePrefix?
  public let firstName: String?
  public let lastName: String?
  public let dateOfBirth: String?
  public let active: Bool?
  public let activeUntil: String?
  public let photographyConsent: Bool?
  public let allergies: String?

  // Relations
  public let parentIds: [UUID]?
  public let branchIds: [Int]?
  public let dayIds: [Int]?

  public init(
    prefix: TitlePrefix? = nil,
    firstName: String? = nil,
    lastName: String? = nil,
    dateOfBirth: String? = nil,
    active: Bool? = nil,
    activeUntil: String? = nil,
    photographyConsent: Bool? = nil,
    allergies: String? = nil,
    parentIds: [UUID]? = nil,
    branchIds: [Int]? = nil,
    dayIds: [Int]? = nil
  ) {
    self.prefix = prefix
    self.firstName = firstName
    self.lastName = lastName
    self.dateOfBirth = dateOfBirth
    self.active = active
    self.activeUntil = activeUntil
    self.photographyConsent = photographyConsent
    self.allergies = allergies
    self.parentIds = parentIds
    self.branchIds = branchIds
    self.dayIds = dayIds
  }

  /// Convert to the basic UpdatePupilRequestModel (for internal API separation)
  public var pupilData: UpdatePupilRequestModel {
    UpdatePupilRequestModel(
      prefix: prefix,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      active: active,
      activeUntil: activeUntil,
      photographyConsent: photographyConsent,
      allergies: allergies
    )
  }
}
