//
//  NewParentRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created on 19/11/2025.
//

import Foundation

public struct NewParentRequestModel: Codable, Equatable, Sendable {
  public let prefix: TitlePrefix
  public let firstName: String
  public let lastName: String
  public let active: Bool
  public let facilitating: Bool
  public let phone: String
  public let email: String

  @available(*, deprecated, message: "This property is no longer used")
  public let primary: Bool?

  public init(
    prefix: TitlePrefix,
    firstName: String,
    lastName: String,
    active: Bool,
    facilitating: Bool,
    phone: String,
    email: String,
    primary: Bool? = nil
  ) {
    self.prefix = prefix
    self.firstName = firstName
    self.lastName = lastName
    self.active = active
    self.facilitating = facilitating
    self.phone = phone
    self.email = email
    self.primary = primary
  }
}
