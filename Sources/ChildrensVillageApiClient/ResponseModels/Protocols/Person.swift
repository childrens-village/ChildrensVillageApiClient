//
//  Person.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 25/06/2025.
//

import Foundation

public protocol Person: Identifiable, Sendable {
  var id: UUID { get }
  var prefix: TitlePrefix { get }
  var firstName: String { get }
  var lastName: String { get }
}
