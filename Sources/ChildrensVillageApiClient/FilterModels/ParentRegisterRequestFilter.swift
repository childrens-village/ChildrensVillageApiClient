//
//  ParentRegisterRequestFilter.swift
//  
//
//  Created by Chris Kobrzak on 05/12/2022.
//

import Foundation

typealias APRRF = ParentRegisterRequestFilter

struct ParentRegisterRequestFilter: Encodable, Equatable {
  var include: [DaysOfWeekRelation]
}
