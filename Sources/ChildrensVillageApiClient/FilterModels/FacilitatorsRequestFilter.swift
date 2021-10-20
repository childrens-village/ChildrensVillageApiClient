//
//  FacilitatorsRequestFilter.swift
//  Represents GET all-active-facilitators request filter
//
//  Created by Chris Kobrzak on 20/10/2021.
//

import Foundation

typealias FRF = FacilitatorsRequestFilter

public struct FacilitatorsRequestFilter: Codable, Equatable {
  var fields: Field
  var `where`: Where
  var order: String

  struct Field: Codable, Equatable {
    var id: Bool
    var primary: Bool?
    var firstName: Bool
    var lastName: Bool
    var prefix: Bool
    var phone: Bool
    var email: Bool
  }

  struct Where: Codable, Equatable {
    var active: Bool
    var facilitating: Bool
  }
}
