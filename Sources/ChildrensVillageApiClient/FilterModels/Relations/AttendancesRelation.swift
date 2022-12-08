//
//  AttendancesRelation.swift
//  
//  Created by Chris Kobrzak on 31/10/2021.
//

import Foundation

typealias ARRF = AttendancesRelation

public struct AttendancesRelation: Encodable, Equatable {
  var fields: Field?
  var `where`: Where?
  var relation: String?
  var scope: Scope?

  struct Field: Encodable, Equatable {
    var pupilId: Bool?
  }

  struct Scope: Encodable, Equatable {
    var `where`: Where
  }

  struct Where: Encodable, Equatable {
    var date: String
    var branchId: Int?
  }
}
