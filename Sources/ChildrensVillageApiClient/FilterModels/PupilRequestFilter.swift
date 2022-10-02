//
//  PupilRequestFilter.swift
//  Represents GET pupil request filter
//
//  Created by Chris Kobrzak on 18/08/2022.
//

import Foundation

typealias PRF = PupilRequestFilter

public struct PupilRequestFilter: Codable, Equatable {
  var fields: Field
  var include: [Include]

  struct Field: Codable, Equatable {
    var id: Bool
    var active: Bool
    var firstName: Bool
    var lastName: Bool
    var prefix: Bool
    var dateOfBirth: Bool
    var photographyConsent: Bool
    var allergies: Bool
  }
}
