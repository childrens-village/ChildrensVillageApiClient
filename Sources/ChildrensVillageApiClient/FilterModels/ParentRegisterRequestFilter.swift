//
//  ParentRegisterRequestFilter.swift
//  
//
//  Created by Chris Kobrzak on 05/12/2022.
//

import Foundation

typealias APRRF = ParentRegisterRequestFilter

public struct ParentRegisterRequestFilter: Codable, Equatable {
  var include: [DaysOfWeekRelation]

  struct DaysOfWeekRelation: Codable, Equatable {
    var relation: String
    var scope: DaysOfWeekScope
  }

  struct DaysOfWeekScope: Codable, Equatable {
    var `where`: DaysOfWeekWhere
    var include: [PupilsRelation]

    struct DaysOfWeekWhere: Codable, Equatable {
      var day: DayOfWeek
    }
  }

  struct PupilsRelation: Codable, Equatable {
    var relation: String
    var scope: PupilsScope
  }

  struct PupilsScope: Codable, Equatable {
    var `where`: PupilOrPredicate
    var include: [ParentsRelation]

    struct PupilOrPredicate: Codable, Equatable {
      var or: [PupilWhere]
    }

    struct PupilWhere: Codable, Equatable {
      var active: Bool?
      var id: PredicateInUuid?
    }

    struct ParentsRelation: Codable, Equatable {
      var relation: String
      var scope: ParentsScope
    }
  }

  struct ParentsScope: Codable, Equatable {
    var include: [AttendancesRelation]
  }
}
