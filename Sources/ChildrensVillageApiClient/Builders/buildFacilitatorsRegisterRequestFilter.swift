//
//  buildFacilitatorsRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the all-active-facilitators API request query string.
//
//  Created by Chris Kobrzak on 20/10/2021.
//

import Foundation

func buildFacilitatorsRegisterRequestFilter(_ date: Date) -> FacilitatorsRegisterRequestFilter {
  let (isoDate, _) = getLocalIsoTimeParts(date)

  return FRRF(
    fields: FRRF.Field(
      id: true,
      firstName: true,
      lastName: true,
      prefix: true,
      phone: true,
      email: true
    ),
    include: [
      Relation(
        relation: "attendances",
        scope: Relation.Scope(
          where: Relation.Where(
            date: isoDate
          )
        )
      )
    ],
    where: FRRF.Where(
      active: true,
      facilitating: true
    ),
    order: "firstName, lastName"
  )
}
