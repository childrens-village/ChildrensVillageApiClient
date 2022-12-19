//
//  FacilitatorsRequestFilter.swift
//  Represents GET all-active-facilitators request filter
//
//  Created by Chris Kobrzak on 20/10/2021.
//

import Foundation

typealias FRRF = FacilitatorsRegisterRequestFilter

struct FacilitatorsRegisterRequestFilter: Encodable, Equatable {
  var fields: Field
  var include: [Relation]
  var `where`: Where
  var order: String

  struct Field: Encodable, Equatable {
    var id: Bool
    var primary: Bool?
    var firstName: Bool
    var lastName: Bool
    var prefix: Bool
    var phone: Bool
    var email: Bool
  }

  struct Where: Encodable, Equatable {
    var active: Bool
    var facilitating: Bool
  }
}
