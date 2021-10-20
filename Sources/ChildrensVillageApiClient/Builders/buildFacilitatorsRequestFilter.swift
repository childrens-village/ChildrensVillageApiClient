//
//  buildFacilitatorsRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the all-active-facilitators API request query string.
//
//  Created by Chris Kobrzak on 20/10/2021.
//

import Foundation

public func buildFacilitatorsRequestFilter() -> FacilitatorsRequestFilter? {
  return FRF(
    fields: FRF.Field(
      id: true,
      firstName: true,
      lastName: true,
      prefix: true,
      phone: true,
      email: true
    ),
    where: FRF.Where(
      active: true,
      facilitating: true
    ),
    order: "firstName, lastName"
  )
}
