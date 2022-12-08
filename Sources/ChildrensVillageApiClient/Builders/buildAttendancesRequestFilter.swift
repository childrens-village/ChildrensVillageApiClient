//
//  buildAttendancesRequestFilter.swift
//
//  Created by Chris Kobrzak on 29/10/2022.
//

import Foundation

public func buildAttendancesRequestFilter(_ branchId: Int, _ date: Date) -> AttendancesRelation {
  let (isoDate, _) = getLocalIsoTimeParts(date)

  return ARRF(
    fields: ARRF.Field(pupilId: true),
    where: ARRF.Where(date: isoDate, branchId: branchId)
  )
}
