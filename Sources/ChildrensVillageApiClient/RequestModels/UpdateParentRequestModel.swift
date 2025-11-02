//
//  UpdateParentRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created on 2/11/2025.
//

import Foundation

public struct UpdateParentRequestModel: Codable, Equatable {
  public let prefix: TitlePrefix?
  public let firstName: String?
  public let lastName: String?
  public let active: Bool?
  public let facilitating: Bool?
  public let phone: String?
  public let email: String?

  public init(
    prefix: TitlePrefix? = nil,
    firstName: String? = nil,
    lastName: String? = nil,
    active: Bool? = nil,
    facilitating: Bool? = nil,
    phone: String? = nil,
    email: String? = nil
  ) {
    self.prefix = prefix
    self.firstName = firstName
    self.lastName = lastName
    self.active = active
    self.facilitating = facilitating
    self.phone = phone
    self.email = email
  }
}