//
//  buildAttendancesRequestFilter.swift
//
//  Created by Chris Kobrzak on 29/10/2022.
//

import Foundation

func buildAttendancesRequestFilter(_ branchId: Int, _ date: Date) -> Relation {
  let (isoDate, _) = getLocalIsoTimeParts(date)

  return Relation(
    fields: Relation.Field(pupilId: true),
    where: Relation.Where(date: isoDate, branchId: branchId)
  )
}
