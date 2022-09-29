//
//  buildPupilRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the pupil API request query string.
//
//  Created by Chris Kobrzak on 18/08/2022.
//

import Foundation

public func buildPupilRequestFilter() -> PupilRequestFilter {
  return PRF(
    fields: PRF.Field(
      id: true,
      active: true,
      firstName: true,
      lastName: true,
      prefix: true,
      dateOfBirth: true
    ),
    include: [
      Include(relation: "parents"),
      Include(relation: "branches"),
      Include(relation: "daysOfWeek")
    ]
  )
}
