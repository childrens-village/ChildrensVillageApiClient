//
//  buildClockOnRequestBody.swift
//  buildClockOnRequestBody
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import Foundation

public func buildClockOnRequestBody(_ pupilId: String, branchId: Int, date: String, time: String) -> ClockOnRequestBody {
  ClockOnRequestBody(
     pupilId: pupilId,
     branchId: branchId,
     date: date,
     clockOnTime: time
  )
}
