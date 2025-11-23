//
//  buildParentRequestFilter.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 19/11/2025.
//

import Foundation

func buildParentRequestFilter() -> ParentRequestFilter {
  return GRF(
    fields: GRF.Field(
      id: true,
      active: true,
      facilitating: true,
      prefix: true,
      firstName: true,
      lastName: true,
      phone: true,
      email: true
    )
  )
}
