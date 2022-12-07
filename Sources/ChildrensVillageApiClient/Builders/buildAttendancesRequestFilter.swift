//
//  buildAttendancesRequestFilter.swift
//
//  Created by Chris Kobrzak on 29/10/2022.
//

import Foundation

public func buildAttendancesRequestFilter(_ branchId: Int, _ date: Date) -> AttendancesRelation {
  let (isoDate, _) = getLocalIsoTimeParts(date)

  return ARRF(
    fields: ARRF.AttendanceField(pupilId: true),
    where: ARRF.AttendancesScope.AttendancesWhere(date: isoDate, branchId: branchId)
  )
}
