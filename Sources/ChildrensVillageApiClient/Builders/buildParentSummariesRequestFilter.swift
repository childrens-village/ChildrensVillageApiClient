//
//  buildParentSummariesRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the parent summaries API request query string.
//
//  Created on 25/06/2025.
//

import Foundation

func buildParentSummariesRequestFilter() -> ParentSummariesRequestFilter {
  return ASRF(
    fields: ASRF.Field(
      id: true,
      active: true,
      facilitating: true,
      firstName: true,
      lastName: true,
      prefix: true
    ),
    order: "lastName, firstName"
  )
}
