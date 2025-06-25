//
//  buildPupilSummariesRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the pupils API request query string.
//
//  Created by Claude Sonnet based on the TypeScript equivalent on 25/06/2025.
//

import Foundation

func buildPupilSummariesRequestFilter() -> PupilSummariesRequestFilter {
  return PSRF(
    fields: PSRF.Field(
      id: true,
      active: true,
      firstName: true,
      lastName: true,
      dateOfBirth: false,
      prefix: true
    ),
    order: "firstName"
  )
}
