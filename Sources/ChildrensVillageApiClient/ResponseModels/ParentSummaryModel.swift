//
//  ParentSummaryModel.swift
//  ChildrensVillageApiClient
//
//  Created on 25/06/2025.
//

import Foundation

public struct ParentSummaryModel: Codable, Equatable {
  public let prefix: TitlePrefix
  public let firstName: String
  public let lastName: String
  public let active: Bool
  public let facilitating: Bool
}
