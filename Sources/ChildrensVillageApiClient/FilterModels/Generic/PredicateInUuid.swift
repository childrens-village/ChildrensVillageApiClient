//
//  PredicateIn.swift
//
//  Created by Chris Kobrzak on 29/10/2022.
//

import Foundation

// TODO: Is there a generic way to represent the UUID?
struct PredicateInUuid: Codable, Equatable {
  var inq: [UUID]
}
