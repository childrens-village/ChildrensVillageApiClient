//
//  AttendancesRelation.swift
//  
//  Created by Chris Kobrzak on 31/10/2021.
//

import Foundation

typealias ARRF = AttendancesRelation

public struct AttendancesRelation: Codable, Equatable {
  var fields: AttendanceField?
  var `where`: AttendancesWhere?
  var relation: String?
  var scope: AttendancesScope?

  struct AttendanceField: Codable, Equatable {
    var pupilId: Bool?
  }

  struct AttendancesScope: Codable, Equatable {
    var `where`: AttendancesWhere
  }

  struct AttendancesWhere: Codable, Equatable {
    var date: String
    var branchId: Int?
  }
}
