//
//  DaysOfWeekRelation.swift
//  
//
//  Created by Chris Kobrzak on 07/12/2022.
//

import Foundation

typealias DOWR = DaysOfWeekRelation

struct DaysOfWeekRelation: Encodable, Equatable {
  var relation: String
  var scope: Scope
  
  struct Scope: Encodable, Equatable {
    var `where`: Where
    var include: [PupilsRelation]
  }

  struct Where: Encodable, Equatable {
    var day: DayOfWeek
  }
}
