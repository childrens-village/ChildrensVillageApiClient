//
//  NewParentRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created on 25/06/2025.
//

import Foundation

public struct NewParentRequestModel: Codable, Equatable {
  public let prefix: TitlePrefix
  public let firstName: String
  public let lastName: String
  public let active: Bool
  public let facilitating: Bool
  public let phone: String
  public let email: String

  @available(*, deprecated, message: "This property is no longer used")
  public let primary: Bool?
}
