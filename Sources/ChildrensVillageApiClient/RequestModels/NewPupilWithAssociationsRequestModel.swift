//
//  NewPupilWithAssociationsRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created on 19/11/2025.
//

import Foundation

/// A comprehensive request model for creating a new pupil with all associated data
public struct NewPupilWithAssociationsRequestModel: Codable, Equatable, Sendable {
  // Core pupil data
  public let prefix: TitlePrefix
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let active: Bool
  public let activeUntil: String?
  public let photographyConsent: Bool
  public let allergies: String?

  // Associations
  public let parentIds: [UUID]
  public let branchIds: [Int]
  public let dayIds: [Int]

  public init(
    prefix: TitlePrefix,
    firstName: String,
    lastName: String,
    dateOfBirth: String? = nil,
    active: Bool = false,
    activeUntil: String? = nil,
    photographyConsent: Bool = false,
    allergies: String? = nil,
    parentIds: [UUID] = [],
    branchIds: [Int] = [],
    dayIds: [Int] = []
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

  /// Convert to the basic NewPupilRequestModel (for internal API separation)
  public var pupilData: NewPupilRequestModel {
    NewPupilRequestModel(
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