//
//  PupilResponse.swift
//  Please note, this is currently a clone of the Pupil model
//
//  Created by Chris Kobrzak on 19/09/2022.
//

import Foundation

extension PupilModel {
  enum CodingKeys: CodingKey {
    case id
    case firstName
    case lastName
    case dateOfBirth
    case prefix
    case parents
    case attendances
    case branches
    case daysOfWeek
  }

  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
        let id = try? container.decode(UUID.self, forKey: .id),
        let firstName = try? container.decode(String.self, forKey: .firstName),
        let lastName = try? container.decode(String.self, forKey: .lastName),
        let prefix = try? container.decode(TitlePrefix.self, forKey: .prefix) else {
      throw try ErrorResponse(from: decoder).error
    }

    let dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth)
    let daysOfWeek = try container.decodeIfPresent([DayOfWeekModel].self, forKey: .daysOfWeek)
    let parents = try container.decodeIfPresent([ParentModel].self, forKey: .parents)
    let attendances = try container.decodeIfPresent([AttendanceModel].self, forKey: .attendances)
    let branches = try container.decodeIfPresent([BranchModel].self, forKey: .branches)

    self.init(
      id: id,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      prefix: prefix,
      parents: parents,
      attendances: attendances,
      branches: branches,
      daysOfWeek: daysOfWeek
    )
  }
}
