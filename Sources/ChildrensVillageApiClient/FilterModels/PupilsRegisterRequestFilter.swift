//
//  DailyRegisterRequestFilter.swift
//  DailyRegisterRequestFilter
//
//  Created by Chris Kobrzak on 25/07/2021.
//

import Foundation

typealias PRRF = PupilsRegisterRequestFilter

public struct PupilsRegisterRequestFilter: Encodable, Equatable {
  var include: [DaysOfWeekRelation]
}
