//
//  ClockOnRequestUrlFilter.swift
//  ClockOnRequestUrlFilter
//
//  Created by Chris Kobrzak on 25/07/2021.
//

import Foundation

public struct ClockOnRequestUrlFilter: Codable, Equatable {
  var pupilId: String
  var branchId: Int
  var date: String
  var clockOnTime: String
}
