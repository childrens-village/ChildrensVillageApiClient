//
//  Relation.swift
//  Represents various relation types used in the include array in
//  request filters.
//
//  Created by Chris Kobrzak on 07/12/2022.
//

import Foundation

enum Relation: Encodable, Equatable {
  case attendance([AttendancesRelation])
  case parent([ParentsRelation])

  /*
  enum CodingKeys: String, CodingKey {
    case attendance
    case parent
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(attendance, forKey: .attendance)
    try container.encode(parent, forKey: .parent)

    switch data {
    case .number(let values):
      try container.encode("number", forKey: .type)
      try container.encode(values, forKey: .data)
    case .plot(let values):
      try container.encode("plot", forKey: .type)
      try container.encode(values, forKey: .data)
    case .slice(let values):
      try container.encode("slice", forKey: .type)
      try container.encode(values, forKey: .data)
    }
  }
  */
}
