//
//  Relation.swift
//  Represents various relation types used in the include array in
//  request filters.
//
//  Created by Chris Kobrzak on 07/12/2022.
//

import Foundation

struct Relation: Encodable, Equatable {
  var fields: Field?
  var `where`: Where?
  var relation: String?
  var scope: Scope?

  struct Field: Encodable, Equatable {
    var pupilId: Bool?
  }

  struct Where: Encodable, Equatable {
    var date: String
    var branchId: Int?
  }

  struct Scope: Encodable, Equatable {
    var `where`: Where?
    var include: [Relation]?
  }
}
