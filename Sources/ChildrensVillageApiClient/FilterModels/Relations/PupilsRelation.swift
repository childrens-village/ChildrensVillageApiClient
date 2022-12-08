//
//  PupilsRelation.swift
//  
//
//  Created by Chris Kobrzak on 07/12/2022.
//

import Foundation

typealias PR = PupilsRelation

struct PupilsRelation: Encodable, Equatable {
  var relation: String
  var scope: Scope
  
  struct Predicate: Encodable, Equatable {
    var or: [Where]
  }
  
  struct Where: Encodable, Equatable {
    var active: Bool?
    var id: PredicateInUuid?
  }

  // Override encode() to support multiple types for the `include` key below
  struct Scope: Encodable, Equatable {
    var `where`: PR.Predicate
    var order: String?
    // TODO: How to support [Relation]?
    var include: Relation
    
    enum CodingKeys: String, CodingKey {
      case `where`, order, include
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(`where`, forKey: .where)
      try container.encodeIfPresent(order, forKey: .order)
      
      switch include {
      case .attendance(let values):
        try container.encode(values, forKey: .include)
      case .parent(let values):
        try container.encode(values, forKey: .include)
      }
    }

    /*
    // Add `type` coding key above if you ned to decode
    init(from decoder: Decoder) throws {
      var container = try decoder.container(keyedBy: CodingKeys.self)
      `where` = try container.decode(Predicate.self, forKey: .where)
      order = try container.decode(String.self, forKey: .order)
      
      let type = try container.decode(String.self, forKey: .type)
      switch type {
      case "attendance":
        let values = try container.decode([AttendancesRelation].self, forKey: .include)
        include = .attendance(values)
      case "parent":
        let values = try container.decode([ParentsRelation].self, forKey: .include)
        include = .parent(values)
        // case ...
      default:
        fatalError("Unsupported type for Relation: \(type)")
      }
    }
    */
  }
}
