//
//  UpdatePupilRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created on 2/11/2025.
//

import Foundation

public struct UpdatePupilRequestModel: Codable, Equatable, Sendable {
  public let prefix: TitlePrefix?
  public let firstName: String?
  public let lastName: String?
  public let dateOfBirth: String?
  public let active: Bool?
  public let activeUntil: String?
  public let photographyConsent: Bool?
  public let allergies: String?

  public init(
    prefix: TitlePrefix? = nil,
    firstName: String? = nil,
    lastName: String? = nil,
    dateOfBirth: String? = nil,
    active: Bool? = nil,
    activeUntil: String? = nil,
    photographyConsent: Bool? = nil,
    allergies: String? = nil
  ) {
    self.prefix = prefix
    self.firstName = firstName
    self.lastName = lastName
    self.dateOfBirth = dateOfBirth
    self.active = active
    self.activeUntil = activeUntil
    self.photographyConsent = photographyConsent
    self.allergies = allergies
  }
}
