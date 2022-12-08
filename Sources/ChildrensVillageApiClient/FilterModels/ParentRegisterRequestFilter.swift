//
//  ParentRegisterRequestFilter.swift
//  
//
//  Created by Chris Kobrzak on 05/12/2022.
//

import Foundation

typealias APRRF = ParentRegisterRequestFilter

// Please note, this type is currently identical as PupilsRegisterRequestFilter
struct ParentRegisterRequestFilter: Encodable, Equatable {
  var include: [DaysOfWeekRelation]
}
