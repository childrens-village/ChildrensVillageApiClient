//
//  ParentSummariesRequestFilter.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 25/06/2025.
//


typealias ASRF = ParentSummariesRequestFilter

struct ParentSummariesRequestFilter: Codable {
  let fields: Field
  let order: String

  struct Field: Codable {
    let id: Bool
    let active: Bool
    let facilitating: Bool
    let firstName: Bool
    let lastName: Bool
    let prefix: Bool
  }
}