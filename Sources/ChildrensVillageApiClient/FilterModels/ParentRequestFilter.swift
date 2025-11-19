//
//  ParentRequestFilter.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 19/11/2025.
//

// G stands for Guardian (PRF already taken)
typealias GRF = ParentRequestFilter

struct ParentRequestFilter: Encodable, Equatable {
  var fields: Field?
  var `where`: Where?

  struct Field: Encodable, Equatable {
    var id: Bool
    var active: Bool
    var facilitating: Bool
    var prefix: Bool
    var firstName: Bool
    var lastName: Bool
    var phone: Bool
    var email: Bool
  }

  struct Where: Encodable, Equatable {
    var active: Bool?
    var id: PredicateInUuid?
  }
}
