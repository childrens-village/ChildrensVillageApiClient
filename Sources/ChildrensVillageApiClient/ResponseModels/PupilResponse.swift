//
//  PupilResponse.swift
//  Please note, this is currently a clone of the Pupil model
//
//  Created by Chris Kobrzak on 19/09/2022.
//

import Foundation

struct PupilResponse: Attending, Identifiable, Decodable {
  public let id: UUID
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String?
  public let prefix: TitlePrefix
  public let parents: [Parent]?
  public let attendances: [Attendance]?
  public let branches: [Branch]?
  public let daysOfWeek: [DayOfWeekModel]?
}

extension PupilResponse {
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
        let prefix = try? container.decode(TitlePrefix.self, forKey: .prefix),
        // Optional properties
        let dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth),
        let parents = try container.decodeIfPresent([Parent].self, forKey: .parents),
        let attendances = try container.decodeIfPresent([Attendance].self, forKey: .attendances),
        let branches = try container.decodeIfPresent([Branch].self, forKey: .branches),
        let daysOfWeek = try container.decodeIfPresent([DayOfWeekModel].self, forKey: .daysOfWeek) else {
      throw try ErrorResponse(from: decoder).error
    }

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
