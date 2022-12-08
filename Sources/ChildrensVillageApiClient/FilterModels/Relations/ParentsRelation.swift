//
//  ParentsRelation.swift
//  
//
//  Created by Chris Kobrzak on 07/12/2022.
//

import Foundation

typealias APR = ParentsRelation

struct ParentsRelation: Encodable, Equatable {
  var relation: String
  var scope: Scope
  
  struct Scope: Encodable, Equatable {
    var include: [AttendancesRelation]
  }
}
