//
//  AttendancesRelation.swift
//  
//  Created by Chris Kobrzak on 31/10/2021.
//

import Foundation

typealias ARRF = AttendancesRelation

struct AttendancesRelation: Codable, Equatable {
  var relation: String
  var scope: AttendancesScope

  struct AttendancesScope: Codable, Equatable {
    var `where`: AttendancesWhere
  }

  struct AttendancesWhere: Codable, Equatable {
    var date: String
  }
}
