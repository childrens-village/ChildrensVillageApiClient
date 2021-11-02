//
//  buildFacilitatorsRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the all-active-facilitators API request query string.
//
//  Created by Chris Kobrzak on 20/10/2021.
//

import Foundation

public func buildFacilitatorsRequestFilter(_ date: Date) -> FacilitatorsRequestFilter {
  let (isoDate, _, _) = getLocalIsoTimeParts(date)

  return FRF(
    fields: FRF.Field(
      id: true,
      firstName: true,
      lastName: true,
      prefix: true,
      phone: true,
      email: true
    ),
    include: [
      ARRF(
        relation: "attendances",
        scope: ARRF.AttendancesScope(
          where: ARRF.AttendancesWhere(
            date: isoDate
          )
        )
      )
    ],
    where: FRF.Where(
      active: true,
      facilitating: true
    ),
    order: "firstName, lastName"
  )
}
