//
//  PupilsRequestFilter.swift
//  
//
//  Created on 25/06/2025.
//

import Foundation

typealias PSRF = PupilSummariesRequestFilter

struct PupilSummariesRequestFilter: Encodable {
  let fields: Field
  let order: String
  
  struct Field: Encodable {
    let id: Bool
    let active: Bool
    let firstName: Bool
    let lastName: Bool
    let dateOfBirth: Bool
    let prefix: Bool
  }
}
