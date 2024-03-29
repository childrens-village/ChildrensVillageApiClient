//
//  buildPupilRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the pupil API request query string.
//
//  Created by Chris Kobrzak on 18/08/2022.
//

import Foundation

func buildPupilRequestFilter() -> PupilRequestFilter {
  return PRF(
    fields: PRF.Field(
      id: true,
      active: true,
      activeUntil: true,
      firstName: true,
      lastName: true,
      prefix: true,
      dateOfBirth: true,
      photographyConsent: true,
      allergies: true
    ),
    include: [
      Include(relation: "parents"),
      Include(relation: "branches"),
      Include(relation: "daysOfWeek")
    ]
  )
}
