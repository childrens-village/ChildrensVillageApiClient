//
//  NewPupilRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 25/06/2025.
//
import Foundation

// TODO: Could this type be merged with UpdatePupilRequestModel?
public struct NewPupilRequestModel: Codable, Equatable, Sendable {
  public let prefix: TitlePrefix
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let active: Bool
  public let activeUntil: String?
  public let photographyConsent: Bool
  public let allergies: String?

  public init(
    prefix: TitlePrefix,
    firstName: String,
    lastName: String,
    dateOfBirth: String? = nil,
    active: Bool = false,
    activeUntil: String? = nil,
    photographyConsent: Bool = false,
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
