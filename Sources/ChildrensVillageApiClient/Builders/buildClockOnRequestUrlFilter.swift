//
//  buildDailyRegisterRequestFilter.swift
//  buildDailyRegisterRequestFilter
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import Foundation

public func buildClockOnRequestUrlFilter(_ pupilId: String, branchId: Int, date: String, time: String) -> ClockOnRequestUrlFilter {
  ClockOnRequestUrlFilter(
     pupilId: pupilId,
     branchId: branchId,
     date: date,
     clockOnTime: time
  )
}
