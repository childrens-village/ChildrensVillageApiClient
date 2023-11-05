//
//  PupilRequestFilter.swift
//  Represents GET pupil request filter
//
//  Created by Chris Kobrzak on 18/08/2022.
//

import Foundation

typealias PRF = PupilRequestFilter

struct PupilRequestFilter: Encodable, Equatable {
  var fields: Field?
  var include: [Include]?
  var `where`: Where?

  struct Field: Encodable, Equatable {
    var id: Bool
    var active: Bool
    var activeUntil: Bool
    var firstName: Bool
    var lastName: Bool
    var prefix: Bool
    var dateOfBirth: Bool
    var photographyConsent: Bool
    var allergies: Bool
  }

  struct Where: Encodable, Equatable {
    var active: Bool?
    var id: PredicateInUuid?
  }
}
