//
//  DailyRegisterRequestFilter.swift
//  DailyRegisterRequestFilter
//
//  Created by Chris Kobrzak on 25/07/2021.
//

import Foundation

typealias DRFRN = DailyRegisterFilterRequestNode

public struct DailyRegisterFilterRequestNode: Codable, Equatable {
  var include: [DaysOfWeekRelation]

  struct DaysOfWeekRelation: Codable, Equatable {
    var relation: String
    var scope: DaysOfWeekScope
  }

  struct DaysOfWeekWhere: Codable, Equatable {
    var day: DayOfWeek
  }

  struct DaysOfWeekScope: Codable, Equatable {
    var `where`: DaysOfWeekWhere
    var include: [PupilsRelation]
  }

  struct PupilsRelation: Codable, Equatable {
    var relation: String
    var scope: PupilsScope
  }

  struct PupilsScope: Codable, Equatable {
    var order: String?
    var include: [AttendancesRelation]
  }

  struct AttendancesRelation: Codable, Equatable {
    var relation: String
    var scope: AttendancesScope
  }

  struct AttendancesScope: Codable, Equatable {
    var `where`: AttendancesWhere
  }

  struct AttendancesWhere: Codable, Equatable {
    var date: String
  }
}
