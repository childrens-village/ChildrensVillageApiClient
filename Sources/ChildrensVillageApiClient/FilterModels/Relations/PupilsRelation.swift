//
//  PupilsRelation.swift
//  
//
//  Created by Chris Kobrzak on 07/12/2022.
//

import Foundation

typealias PR = PupilsRelation

struct PupilsRelation: Encodable, Equatable {
  var relation: String
  var scope: Scope

  struct Scope: Encodable, Equatable {
    var `where`: Predicate
    var order: String?
    var include: [Relation]
  }

  struct Predicate: Encodable, Equatable {
    var or: [Where]
  }

  struct Where: Encodable, Equatable {
    var active: Bool?
    var id: PredicateInUuid?
  }
}
